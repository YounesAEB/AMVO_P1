function [b] = field2vector(d)
% field2vector(d) transforms a scalar field with a centered mesh into an
% unidimensional algebraic vector. 
% Written by: Group 13
% Note: the algebraic vector is sorted from left to right and down up.

    N  = size(d,1) - 2;
    b = zeros(N*N,1);
    
    for j=2:N+1
        for i=2:N+1
            b((i-1) + N*(j-2)) = d(i,j);
        end
    end
end