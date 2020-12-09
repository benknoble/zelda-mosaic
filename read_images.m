function images = read_images(glob)
    images = dir(glob);
    num_images = length(images);
    for k=1:num_images
        [I, map, ~] = imread(fullfile(images(k).folder, images(k).name));
        % some images are "indexed" and need colormaps
        % they will be grayscale (size(I) = [x y]) until converted to rgb
        % at which point size(I) = [x y 3]
        if numel(size(I)) ~= 3
            I = ind2rgb(I, map);
        end
        images(k).I = im2double(I);
    end
end
