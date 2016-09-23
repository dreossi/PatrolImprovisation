function [ coordinates, T ] = genRndMetrGraph( n )
%GENRNDMETRGRAPH Generate a random metric/manhattan graph
    %
    % Input
    % n : number of nodes
    %
    % Output
    % coordinates : nodes coordinates    
    % T : adjacency matrix
    %
    
    T = zeros(n,n);

    coordinates = [0 0];
    
    i = 1;
    while i < n
        % Flip a coin for going vertical or horizontal
        
        nodeIdx = randi([1 i]);
        
        newP = coordinates(nodeIdx,:);
        if rand < 0.5
            if rand < 0.5 % Go down
                newP(1,2) = newP(1,2) - 1;
            else  % Go up
                newP(1,2) = newP(1,2) + 1;
            end            
        else
            if rand < 0.5 % Go left
                newP(1,1) = newP(1,1) - 1;
            else  % Go right
                newP(1,1) = newP(1,1) + 1;
            end          
        end
        
        [~,neighIdx] = ismember(newP,coordinates,'rows');
        
        if neighIdx == 0
            coordinates(end+1,:) = newP;    
            T(nodeIdx,i+1) = 1;
            T(i+1,nodeIdx) = 1;                
            i = i + 1;
        end
    end
    
    m = 10*n;
    % Add some random edges
    for i=1:m
        nodeIdx = randi([1 n]);
        
        % generate random neighbor
        neighp = coordinates(nodeIdx,:);
        if rand < 0.5
            if rand < 0.5 % Go down
                neighp(1,1) = neighp(1,2) - 1;
            else  % Go up
                neighp(1,1) = neighp(1,2) + 1;
            end            
        else
            if rand < 0.5 % Go left
                neighp(1,1) = neighp(1,1) - 1;
            else  % Go right
                neighp(1,1) = neighp(1,1) + 1;
            end          
        end
        
        if any(coordinates(nodeIdx,:) ~= neighp)
            % check if it's in the graph
            [~,neighIdx] = ismember(neighp,coordinates,'rows');
            if neighIdx > 0
                % decide wether to plug them
                if rand > 0.5
                    T(nodeIdx,neighIdx) = 1;
                    T(neighIdx,nodeIdx) = 1;
                end
            end
        end        
    end
    
    plotManGraph(coordinates,T);
end

