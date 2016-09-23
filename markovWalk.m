function [ w ] = markovWalk( v, P, len )
%MARKOVWALK Perform a random walk on Markov chain
    %
    % Input
    % v : starting vertex
    % P : probability matrix
    % len : length of the walk
    %
    % Output
    % w : the walk

    w = [v];    
    
    for i=1:len
        p = rand;
        j = 1;
        while p > sum(P(v,1:j))
            j = j+1;
        end
        v = j;
        w = [w v];       
    end
end

