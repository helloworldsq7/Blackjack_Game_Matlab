clear
close all
clc

% Set sprite image dimensions and other parameters
sprite_height = 16;   % Height of each sprite (in pixels)
sprite_width = 16;    % Width of each sprite (in pixels)
zoom = 4;             % Zoom factor to enlarge the image for better display   
backgroundColor = [128, 128, 128];      

% Create an instance of the game engine and load the sprite sheet containing all images
gameEngine = simpleGameEngine('retro_pack.png', sprite_height, sprite_width, zoom, backgroundColor);

% Define Scene 1, where each number represents the index of a sprite image
scene1 = [529, 1, 1, 1, 1, 1, 531;
    1, 1, 1, 1, 1, 1, 1; 
    1, 981, 991, 980, 982, 990, 1;
    1, 989, 980, 982, 990, 1, 1;
    1, 1, 1, 1, 1, 725, 1;
    593, 1, 1, 1, 1, 1, 595];

% Define Scene 2
scene2 = [916, 949, 950, 951, 1, 1;
    1, 1, 596, 544, 1, 304; 
    1, 1, 1, 1, 1, 1;
    1, 1, 544, 533, 1, 32; 
    916, 951, 948, 951, 1, 1];

% Define Scene 3
scene3 = [916, 948, 1, 1, 1, 1;
    1, 1, 534, 544, 1, 304; 
    1, 1, 1, 1, 1, 1;
    1021, 1, 544, 533, 1, 32; 
    916, 952, 950, 954, 1, 1];

% Store all scenes in a cell array for easy access
scenes = {scene1, scene2, scene3};
% Titles and notes for each scene
titles = {'Scene 1: Initial Deal - Blackjack Begins', 'Game Process - Player and Dealer Actions',...
    'Victory Celebration - Results Revealed'};
notes = {
    'Click on the arrows to start the game.', ...
    'Watch as the game progresses and each player makes their move.', ...
    'Congratulations! Enjoy the victory celebration.'
};

% Define button positions and labels for Scene 2
buttons = {'Hit', 'Stand', 'Split', 'Bet'};
buttonPositions = [0.1, 0.1, 0.15, 0.05; 
    0.3, 0.1, 0.15, 0.05; 
    0.5, 0.1, 0.15, 0.05; 
    0.7, 0.1, 0.15, 0.05];

% Loop through the three scenes
for i = 1:3
    drawScene(gameEngine, scenes{i}); % Draw the current scene
    
    title(titles{i});                 % Set the title for the current scene
    xlabel(notes{i});                 % Set the description for the current scene
    
    if i == 2                         % Pause briefly to allow the player to observe the scene
        for b = 1:length(buttons)
            uicontrol('Style', 'pushbutton', 'String', buttons{b}, ...
                'Units', 'normalized', 'Position', buttonPositions(b, :), ...
                'Callback', @(src, event)disp(['Button pressed: ', buttons{b}]));
        end
    end
    
    % Short pause for observation
    pause(1);  % Pause briefly to allow the player to view the scene
    
    % Wait for user input to continue
    disp('Press any key to view the next scene.');
    gameEngine.getKeyboardInput();
    
    % Delete buttons after Scene 1
    if i == 2
        delete(findall(gcf, 'Style', 'pushbutton'));
    end
end
