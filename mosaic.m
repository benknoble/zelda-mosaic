%%

addpath('mat2tiles');

J = im2double(imread('keyart-resized/twilightprincess.jpg'));
[rows cols n] = size(J);
block_size = 75;
n_blocks = rows / 75 * cols / 75;

chunks = mat2tiles(J, [block_size, block_size]);
[row_chunks col_chunks] = size(chunks);
blocks = zeros(row_chunks, col_chunks, 75, 75, 3);
for i = 1:row_chunks
    for j = 1:col_chunks
        blocks(i, j, :, :, :) = cell2mat(chunks(i, j));
        figure;
        imshow(squeeze(blocks(i, j, :, :, :)))
    end
end