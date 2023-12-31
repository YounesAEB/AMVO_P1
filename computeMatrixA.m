function [A] = computeMatrixA(N)
% computeMatrixA(N) generates a
% Written by: Group 13
% Note: 
    A   = zeros(N*N,N*N);
    aux = zeros(N+2,N+2);
    
    for i=2:N+1
        for j=2:N+1
            aux(i,j) = (i-1)+N*(j-2);                        
        end
    end

    aux = haloUpdate(aux);

    for j=2:N+1
        for i=2:N+1
            c = i-1+N*(j-2);
            
            A(c,aux(i,j))   =-4; % centre node
            A(c,aux(i-1,j)) = 1; % west node
            A(c,aux(i+1,j)) = 1; % east node
            A(c,aux(i,j+1)) = 1; % north node
            A(c,aux(i,j-1)) = 1; % south node
        end
    end

    A(1,1) = -5; % pertorbation    
end