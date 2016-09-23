function [ walk,idls ] = idlHeatMap( T,P,v,len,nRobots,options )
%idlHeatMap Anymation showing the heat map of idleness times
%   Detailed explanation goes here
    %
    % Input
    % T : adjacency matrix    
    % P : probability matrix
    % v : starting vertex
    % len : length of the walk
    % nRobots : number of robots
    % options : some options    
    %
    % Output
    % walk : the walk
    % idls : idleness times

    close all
    
    nodes = size(T,1);     
    
    walk = zeros(nRobots,len);
    idls = ones(nodes,1)*(99999999); 
    
    walk(:,1) = ones(nRobots,1)*v;
    idls(v) = 0;
    
    % Check if there are options    
    if nargin < 5
        options.animation = 0;
    end
    
    if options.animation
        % heat map parameters
        max_hits = 2*nodes;
        col_map = flipud(colormap('jet'));  
    
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
        
        for i=1:nRobots
            robotPos(i) = plot(n(1,1),n(1,2),'or','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10); 
        end
        
        xlab = xlabel(strcat('Step:',{' '},'0/',num2str(len)));
        
        % Visualize color legend
        colorbar
        %pause
    end   
    
    % Random walk
    for i=2:len
        
        for k=1:nRobots
            % Random number in [0,1]
            p = rand;
            j = 1;
            % Pick correspondent edge
            while p > sum(P(walk(k,i-1),1:j))
                j = j+1;
            end
            v = j;
            walk(k,i) = v;  
        end        
        idls = idls+1;
        for k=1:nRobots
            idls(walk(k,i)) = 0; 
        end
        
        if options.animation
            
            for j=1:nRobots
                n = X(walk(j,i),:); 
                set(robotPos(j),'xdata',n(1,1),'ydata',n(1,2)); 
            end
            
            for j=1:nodes
                colnode = round(idls(j)*64/(max_hits)+1);
                if colnode > size(col_map,1)
                    colnode = size(col_map,1);
                end
                set(pn(j),'MarkerFaceColor',col_map(colnode,:));                
            end
            drawnow;
            set(xlab,'String',strcat('Step:',{' '},num2str(i),'/',num2str(len)));           
        end        
    end
end

