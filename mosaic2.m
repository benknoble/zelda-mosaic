function out = mosaic2(J, thumbnails, block_size)
    [rows, cols, ~] = size(J);
    n_blocks = rows / block_size * cols / block_size;
    [n_thumbs, ~, ~, ~] = size(thumbnails);

    threshold = 1;
    if n_thumbs < n_blocks
        threshold = ceil(n_blocks / n_thumbs);
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
            while (used(best_thumbnail_index) >= threshold)
                mses(best_thumbnail_index) = 1;
                best_thumbnail_indices = find(mses == min(mses));
                best_thumbnail_index = best_thumbnail_indices(1); % only take the first
            end
            used(best_thumbnail_index) = used(best_thumbnail_index) + 1;
            chunks{i, j} = squeeze(thumbnails(best_thumbnail_index, :, :, :));
        end
    end

    out = cell2mat(chunks);
end
