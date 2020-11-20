function out = mosaic3(J, thumbnails, block_size)
    [rows, cols, ~] = size(J);
    n_blocks = rows / block_size * cols / block_size;
    [n_thumbs, ~, ~, ~] = size(thumbnails);

    if n_thumbs < n_blocks
        error('n_thumbs (%d) < n_blocks (%d)', n_thumbs, n_blocks)
    end

    chunks = mat2tiles(J, [block_size, block_size]);
    [row_chunks, col_chunks] = size(chunks);
    used = zeros([1, n_thumbs]);

    for i = 1:row_chunks
        for j = 1:col_chunks
            chunk = chunks{i, j};
            mses = ones([1, n_thumbs]);
            for t = 1:n_thumbs
                mses(t) = immse(chunk, squeeze(thumbnails(t, :, :, :)));
            end
            best_thumbnail_indices = find(mses == min(mses));
            best_thumbnail_index = best_thumbnail_indices(1); % only take the first
            while (used(best_thumbnail_index) == 1)
                mses(best_thumbnail_index) = 1;
                best_thumbnail_indices = find(mses == min(mses));
                best_thumbnail_index = best_thumbnail_indices(1); % only take the first
            end
            used(best_thumbnail_index) = 1;
            chunks{i, j} = squeeze(thumbnails(best_thumbnail_index, :, :, :));
        end
    end

    out = cell2mat(chunks);
    out = imgaussfilt(out, 2);
    for x = 75:75:cols-75
        for xx = x-10:x+10
            out(:, xx, :) = mean(out(:, xx-10:xx+10, :), 2);
        end
    end
    for y = 75:75:rows-75
        for yy = y-10:y+10
            out(yy, :, :) = mean(out(yy-10:yy+10, :, :), 1);
        end
    end
end
