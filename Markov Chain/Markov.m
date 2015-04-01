% This code creates a random walk.

% This is on a 1x1 grid, with the bottom left corner at the origin.
clear all
close all
clc


agents = 300;
moves = 1000;


% create location vector
position = zeros(agents,2); % each row is agent, col 1 = x, col 2 = y
loc = zeros(37);


% this loop iterates the position loop for multiple agents
for a = 1:agents
    % Generate starting point (randomly, at any loction on the grid)
    x = rand;
    y = rand;
 

    % this loop gives me the final position of one agent
    for m = 1:moves
        [found] = where(x,y);
        found_i = found;
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
        [found] = where(x,y);
        loc(found_i,found) = loc(found_i,found) + 1;
        
    end
    position(a,1) = x;
    position(a,2) = y;

end


% now i am calculating pij = nji/sum(nji)

totals = repmat(sum(loc),37,1); % total number of steps taken into cell (sum(nji))
pij = loc./totals;
[eigenvector,eigenvalue] = eig(pij);

% the paper only wants the eigenvectors of the ones associated with eivenvalue of 1
one = diag(eigenvalue);
one = find(abs(one - 1) < .001);  % sometimes there are rounding issues


% now we will normalize it!
eigs = eigenvector(:,one);
sum_eigs = sum(eigs);
eignorm = eigs/sum_eigs;

% now we make it into a grid
outside = eignorm(37);
markov_heat = [eignorm(1:6) eignorm(7:12) eignorm(13:18) eignorm(19:24)...
    eignorm(25:30) eignorm(31:36)];



figure;
imagesc(markov_heat);
colorbar;
title('Markov Density')

