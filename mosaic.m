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
            mses = ones([1, n_thumbs]);
            for t = 1:n_thumbs
                mses(t) = immse(chunk, squeeze(thumbnails(t, :, :, :)));
            end
            best_thumbnail_indices = find(mses == min(mses));
            best_thumbnail_index = best_thumbnail_indices(1); % only take the first
            chunks{i, j} = squeeze(thumbnails(best_thumbnail_index, :, :, :));
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
