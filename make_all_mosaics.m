addpath('mat2tiles');

map = @(ks, vs) containers.Map(ks, vs);

block_size = 75;
game_art_dir = 'keyart-resized';
thumbnail_dir = 'thumbnails';

games = [
    map('adventure_of_link', struct('keyart_file', 'adventureoflink.png', 'thumbnail_dir', 'Adventure_of_Link'));
    map('a_link_to_the_past', struct('keyart_file', 'alinktothepast.jpg', 'thumbnail_dir', 'A_Link_to_the_Past'));
    map('breath_of_the_wild', struct('keyart_file', 'breathofthewild.jpg', 'thumbnail_dir', 'Breath_of_the_Wild'));
    map('link_between_worlds', struct('keyart_file', 'linkbetweenworlds.jpg', 'thumbnail_dir', 'Link_Between_Worlds'));
    map('links_awakening', struct('keyart_file', 'linksawakening.jpg', 'thumbnail_dir', 'Link_s_Awakening'));
    map('majoras_mask', struct('keyart_file', 'majorasmask.jpg', 'thumbnail_dir', 'Majora_s_Mask'));
    map('minish_cap', struct('keyart_file', 'minishcap.jpg', 'thumbnail_dir', 'Minish_Cap'));
    map('ocarina_of_time', struct('keyart_file', 'ocarinaoftime.jpg', 'thumbnail_dir', 'Ocarina_of_Time'));
    map('oracle_of_ages', struct('keyart_file', 'oracleofages.jpg', 'thumbnail_dir', 'Oracle_of_Ages'));
    map('oracle_of_seasons', struct('keyart_file', 'oracleofseasons.jpg', 'thumbnail_dir', 'Oracle_of_Seasons'));
    map('phantom_hourglass', struct('keyart_file', 'phantomhourglass.jpg', 'thumbnail_dir', 'Phantom_Hourglass'));
    map('skyward_sword', struct('keyart_file', 'skywardsword.jpg', 'thumbnail_dir', 'Skyward_Sword'));
    map('spirit_tracks', struct('keyart_file', 'spirittracks.jpg', 'thumbnail_dir', 'Spirit_Tracks'));
    map('the_legend_of_zelda', struct('keyart_file', 'thelegendofzelda.jpg', 'thumbnail_dir', 'The_Legend_of_Zelda'));
    map('twilight_princess', struct('keyart_file', 'twilightprincess.jpg', 'thumbnail_dir', 'Twilight_Princess'));
    map('wind_waker', struct('keyart_file', 'windwaker.jpg', 'thumbnail_dir', 'Wind_Waker'));
];

mkdir v1mosaics;
mkdir v2mosaics;
mkdir v3mosaics;

% iterating over the games
for k = games.keys
    key = k{1}; % extract key from cell
    disp([key, ' -->'])
    disp(games(key))

    disp('>>> read image');
    img = im2double(imread(fullfile(game_art_dir, games(key).keyart_file)));
    disp('<<< read image');

    disp('>>> read thumbs');
    thumbs = read_images(fullfile(thumbnail_dir, games(key).thumbnail_dir, '*_*'));
    thumbs_imgs = permute(cat(4, thumbs.I), [4, 1:3]);
    disp('<<< read thumbs');

    disp('>>> make mosaic1');
    new_img = mosaic1(img, thumbs_imgs, block_size);
    imwrite(new_img, fullfile('v1mosaics', [key, '.png']));
    disp('<<< make mosaic1');

    disp('>>> make mosaic2');
    new_img = mosaic2(img, thumbs_imgs, block_size);
    imwrite(new_img, fullfile('v2mosaics', [key, '.png']));
    disp('<<< make mosaic2');

    disp('>>> make mosaic3');
    new_img = mosaic3(img, thumbs_imgs, block_size);
    imwrite(new_img, fullfile('v3mosaics', [key, '.png']));
    disp('<<< make mosaic3');
end

% test
% g = 'breath_of_the_wild';
% img = im2double(imread(fullfile(game_art_dir, games(g).keyart_file)));
% thumbs = read_images(fullfile(thumbnail_dir, games(g).thumbnail_dir, '*_*'));
% new_img = mosaic3(img, permute(cat(4, thumbs.I), [4, 1:3]), block_size);
% figure;
% imshow(new_img);
