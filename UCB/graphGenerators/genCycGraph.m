function [ T ] = genCycGraph( n )
%GENCYVGRAPH Generate a connected symmetric graph out of cycles
    % (This ensures the existence of a uniform stationary disctribution)
    %
    % Input
    % n : number of nodes
    %
    % Output
    % T : adjacency matrix 
    %

    CYC = round(1/5*n + 1);     % number of cycles
    MAX_LEN = round(n/CYC);     % max cycle length
    CONNECT = CYC*2;            % connectivity parameter 
    
    % Generate random cycles
    node_counter = 1;
    tot_nodes = n;
    i = 1;
    while tot_nodes > MAX_LEN
        len = randi([2 MAX_LEN]);        
        cyc{i} = node_counter:node_counter+len;
        tot_nodes = tot_nodes - len;
        node_counter = node_counter+len+1;    
        i = i+1;
    end
    
    % Extract probability matrix
    for i=1:length(cyc)
        cycle = cyc{i};
        for j=1:length(cycle)-1
            T(cycle(j),cycle(j+1)) = 1;
            T(cycle(j+1),cycle(j)) = 1;
        end    
        T(cycle(end),cycle(1)) = 1;
        T(cycle(1),cycle(end)) = 1;
    end
    
    % Connect cycles
    for i=1:length(cyc)-1
        c1 = cyc{i};
        c2 = cyc{i+1};
        n1 = c1(randi([1 length(c1)]));
        n2 = c2(randi([1 length(c2)]));
        T(n1,n2) = 1;
        T(n2,n1) = 1;
    end
    
    
    i = 1;
    while i < CONNECT
        ic1 = randi([1 length(cyc)]);
        ic2 = randi([1 length(cyc)]);
        if (ic1 ~= ic2)
            c1 = cyc{ic1};
            c2 = cyc{ic2};
            n1 = c1(randi([1 length(c1)]));
            n2 = c2(randi([1 length(c2)]));
            T(n1,n2) = 1;
            T(n2,n1) = 1;
            i = i+1;
        end 
    end    

end

