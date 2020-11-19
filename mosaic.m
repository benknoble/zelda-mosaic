function out = mosaic(J, thumbnails, block_size)
    [rows, cols, ~] = size(J);
    n_blocks = rows / block_size * cols / block_size;
    [n_thumbs, ~, ~, ~] = size(thumbnails);

    chunks = mat2tiles(J, [block_size, block_size]);
    [row_chunks, col_chunks] = size(chunks);
    % process
    % e.g.,
    for i = 1:row_chunks
        for j = 1:col_chunks
            chunk = chunks{i, j};
            best_thumbnail = squeeze(thumbnails(1, :, :, :));
            best_mse = immse(chunk, squeeze(thumbnails(1, :, :, :)));
            for t = 1:n_thumbs
                cur_mse = immse(chunk, squeeze(thumbnails(t, :, :, :)));
                if cur_mse < best_mse
                    best_mse = cur_mse;
                    best_thumbnail = squeeze(thumbnails(t, :, :, :));
                end
            end
            chunks{i, j} = best_thumbnail;
            % figure;
            % imshow(chunks{i, j})
        end
    end

    % afterwards, full image
    % e.g.,
    % figure;
    % imshow(cell2mat(chunks))
    out = cell2mat(chunks);
end
