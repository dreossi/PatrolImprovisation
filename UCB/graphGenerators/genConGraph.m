function [ T ] = genConGraph( n )
%GENCONGRAPH Generate a connected symmetric graph with n nodes and at most 2n edges
    % Input
    % n : number of nodes
    %
    % Output
    % T : adjacency matrix 
    %

    MAX_ITER = 2*n;

    T = zeros(n,n);
    for i=2:n
        j = randi([1 i-1]);
        T(i,j) = 1;
        T(j,i) = 1;
    end
    
    for i=1:MAX_ITER
        n1 = randi([1 n]);
        n2 = randi([1 n]);
        if( n1 ~= n2 )
            T(n1,n2) = 1;
            T(n2,n1) = 1;        
        end
    end

end

