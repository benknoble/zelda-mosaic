addpath('mat2tiles');

J = im2double(imread('keyart-resized/twilightprincess.jpg'));
[rows, cols, ~] = size(J);
block_size = 75;
n_blocks = rows / 75 * cols / 75;

chunks = mat2tiles(J, [block_size, block_size]);
[row_chunks, col_chunks] = size(chunks);
for i = 1:row_chunks
    for j = 1:col_chunks
        % process
        % e.g.,
        % figure;
        % imshow(chunks{i, j})
    end
end

% afterwards, full image
% e.g.,
% figure;
% imshow(cell2mat(chunks))
