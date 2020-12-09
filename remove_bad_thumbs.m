thumbnail_dir = 'thumbnails';
thumbss = dir(fullfile(thumbnail_dir, '*_*'));
for inner_dir_i = 1:numel(thumbss)
    num = 0;
    inner_dir = thumbss(inner_dir_i);
    thumbs = read_images(fullfile(inner_dir.folder, inner_dir.name, '*_*'));
    disp(inner_dir.name)
    disp(size(thumbs))
    for thumb = 1:numel(thumbs)
        if numel(size(thumbs(thumb).I)) ~= numel([75 75 3])
            num = num + 1;
            % disp(fullfile(thumbs(thumb).folder, thumbs(thumb).name))
            % delete(fullfile(thumbs(thumb).folder, thumbs(thumb).name))
        end
    end
    disp(num)
end
