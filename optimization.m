function [ P ] = optimization( T, solver )
%OPTIMIZATION Generates a Markov chain using the optimization approach
    % Input
    % T: transition matrix
    %
    % Output
    % P: Markov chain
    
    [n,~] = size(T);
    % Assign an index to each edge of the graph
    map = zeros(n,n);
    key = 0;
    for i=1:n
        for j=1:n
            if T(i,j)
                key = key + 1;
                map(i,j) = key;
            end
        end
    end
    
    % Construct optimization problem
    Aeq = zeros(2*n,key);
    beq = ones(2*n,1);
    for i=1:n
        for j=1:n
            if T(i,j)
               Aeq(i,map(i,j)) = 1; 
            end
        end
    end
    for j=1:n
        for i=1:n
            if T(i,j)
               Aeq(n+j,map(i,j)) = 1; 
            end
        end
    end
%     for i=1:n
%         for j=1:n
%             if T(i,j)
%                Aeq(end+1,map(i,j)) = 1; 
%                Aeq(end,map(j,i)) = -1; 
%                beq = [beq; 0];
%             end
%         end
%     end
    
    if strcmp(solver,'fmincon')
        % Construct the objective function
        fun = @(x)(0);
        for i=1:key
            fun = @(x)( fun(x) + x(i)*log(x(i)) );
        end
    
        % Solve optimization problem
        lb = zeros(key,1);
        ub = ones(key,1);
        opts = optimset('MaxIter', 50000, 'MaxFunEvals', 50000);
        [x,fval] = fmincon(fun,ones(key,1)/2,[],[],Aeq,beq,lb,ub,[],opts);
    else if strcmp(solver,'cvx')
            
            cvx_begin
                variable x(key)
                maximize sum(entr(x))
                subject to
                    Aeq*x == beq
                    0 <= x <= 1
            cvx_end         
        end
    end    
  
    
    % Build markov chain
    P = zeros(n,n);
    key = 1;
    for i=1:n
        for j=1:n
            if T(i,j)
                P(i,j) = x(key);
                key = key + 1;
            end
        end
    end
end

