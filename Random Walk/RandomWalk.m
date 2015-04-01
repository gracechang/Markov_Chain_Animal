% This code creates a random walk.

% This is on a 1x1 grid, with the bottom left corner at the origin.
clear all
close all
clc


agents = 300;
moves = 1000;


% create location vector
position = zeros(agents,2); % each row is agent, col 1 = x, col 2 = y


% this loop iterates the position loop for multiple agents
for a = 1:agents
    % Generate starting point (randomly, at any loction on the grid)
    x = rand;
    y = rand;
 

    % this loop gives me the final position of one agent
    for m = 1:moves
        % Roll x or y, then roll to see if go forward or backward
        r1 = rand;
        r2 = rand;
        if r1 < .5 % check to see if X
            if r2 < .5 % check to see if forward
                x = x + 0.05;
            else
                x = x - 0.05;
            end
        else
            if r2 < .5;
                y = y + 0.05;
            else
                y = y - 0.05;
            end
        end
    end
    position(a,1) = x;
    position(a,2) = y;

end

% Paper divides 1x1 box into 6x6 grid. Now we reassign to those grids.
grid = zeros(6);
for a = 1:agents
    exit_loop = 0;
    for w = 1:6
        for v = 1:6
            if ((1/6)*w - 1/6) <= position(a,1) ...
                    &&  position(a,1) < ((1/6)*w) ...
                    && ((1/6)*v - 1/6) <= position(a,2) ...
                    && position(a,2) < ((1/6)*v)
                grid(v,w) = grid(v,w) + 1;
                exit_loop = 1;
                break;
            end
            if exit_loop == 1
                break;
            end
        end
    end
end

grid
figure;
imagesc(grid);
colorbar;
title('Heat Map for Random Walk');
% We will make note of the number of outsiders and then delete them
%{
maybe_outside = location(:,1) + location(:,2);
out = find(maybe_outside >=40);
outsiders = size(out);
location(out,:) = [];

% Now we put into matrix for heat map
places = zeros(6);

for j = 1:agents-outsiders(1)
    places(location(j,1),location(j,2)) = places(location(j,1),location(j,2)) + 1;
end


% Now we create heat map
figure;
% colormap('hot')
imagesc(places)
colorbar

%}

