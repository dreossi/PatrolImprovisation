function [ walk,hits ] = randomWalk( T,P,v,len,options )
%RANDOMWALK Random walk + possible animation
%   Detailed explanation goes here
    %
    % Input
    % T : adjacency matrix  
    % P : probability matrix    
    % v : starting vertex
    % len : length of the walk    
    % options : some options    
    %
    % Output
    % walk : the walk
    % hits : total number of hits per node

    close all
    
    nodes = size(T,1); 
    walk = zeros(1,len);
    hits = zeros(nodes,1); 
    
    walk(1) = v;
    hits(v) = 1;    
    
    % Check if there are options    
    if nargin < 5
        options.animation = 0;
    end
    
    if options.animation
        % heat map parameters
        max_hits = (len/nodes)*2;
        col_map = colormap('jet');  
    
        xlim([0,1200]); ylim([0,700]);    
        img = imread(options.img);
        imagesc(img);    
        colormap jet    
        hold on    
        
        X = options.coordinates;
        
        % Plot map edges
        for k=1:nodes
            for h=k:nodes
                if T(k,h)
                    n1 = X(k,:);
                    n2 = X(h,:);
                    plot([n1(1,1) n2(1,1)],[n1(1,2) n2(1,2)],'-b');
                end
            end
        end
        % Plot map nodes
        for k=1:nodes
            n = X(k,:);
            pn(k) = plot(n(1,1),n(1,2),'or','MarkerEdgeColor','b','MarkerFaceColor',col_map(1,:),'MarkerSize',5);          
        end
        
        % Plot robot position
        n = X(v,:);
        robot_pos = plot(n(1,1),n(1,2),'or','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10);              
        xlab = xlabel(strcat('Step:',{' '},'0/',num2str(len)));
        
        % Visualize color legend
        colorbar
        %pause
    end   
    
    % Random walk
    for i=2:len
        
        % Random number in [0,1]
        p = rand;
        j = 1;
        % Pick correspondent edge
        while p > sum(P(v,1:j))
            j = j+1;
        end
        v = j;
        walk(i) = v;          
        hits(v) = hits(v) + 1;   
        
        if options.animation
            n = X(v,:); 
            set(robot_pos,'xdata',n(1,1),'ydata',n(1,2));    
            colnode = round(hits(v)*64/(max_hits)+1);
            if colnode > size(col_map,1)
                colnode = size(col_map,1);
            end
            set(pn(v),'MarkerFaceColor',col_map(colnode,:));
            set(xlab,'String',strcat('Step:',{' '},num2str(i),'/',num2str(len)));
            drawnow;
        end        
    end
end

