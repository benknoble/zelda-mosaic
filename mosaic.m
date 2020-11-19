function out = mosaic(J, thumbnails, block_size)
    [rows, cols, ~] = size(J);
    n_blocks = rows / block_size * cols / block_size;

    chunks = mat2tiles(J, [block_size, block_size]);
    [row_chunks, col_chunks] = size(chunks);
    % process
    % e.g.,
    % for i = 1:row_chunks
    %     for j = 1:col_chunks
    %         % figure;
    %         % imshow(chunks{i, j})
    %     end
    % end

    % afterwards, full image
    % e.g.,
    % figure;
    % imshow(cell2mat(chunks))
    out = cell2mat(chunks);
end
