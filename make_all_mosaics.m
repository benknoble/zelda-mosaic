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

% iterating over the games
% e.g.,
for k = games.keys
    key = k{1}; % extract key from cell
    disp([key, ' -->'])
    disp(games(key))
end

% test
img = im2double(imread(fullfile(game_art_dir, games('twilight_princess').keyart_file)));
thumbs = read_images(fullfile(thumbnail_dir, games('twilight_princess').thumbnail_dir, '*_*'));
new_img = mosaic(img, thumbs, block_size);
figure;
imshow(new_img);
