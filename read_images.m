function images = read_images(glob)
    images = dir(glob);
    num_images = length(images);
    for k=1:num_images
        images(k).I = im2double(imread(fullfile(images(k).folder, images(k).name)));
    end
end