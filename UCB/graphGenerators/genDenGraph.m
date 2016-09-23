function [ T ] = genDenGraph( n, min_dens )
%GENDENGRAPH Generate a connected symmetric graph with a certain density
    %
    % Input
    % n : number of nodes
    % min_dens : minimum density
    %
    % Output
    % T : adjacency matrix 
    %

    % Generate connected skeleton
    %T = zeros(n,n);
    T = diag(ones(1,n));
    for i=2:n
        j = randi([1 i-1]);
        T(i,j) = 1;
        T(j,i) = 1;
    end
    
    % Loop until density is reached
    den = graphDensity(T);
    while den < min_dens
        n1 = randi([1 n]);
        n2 = randi([1 n]);
        if( n1 ~= n2 )
            T(n1,n2) = 1;
            T(n2,n1) = 1;        
        end
        den = graphDensity(T);
    end

end

