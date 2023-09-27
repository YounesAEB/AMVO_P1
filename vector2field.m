function [d] = vector2field(b)
% vector2field(b) transforms an unidimensional algebraic vector into a 
% scalar field with a centered mesh.
% Written by: Group 13
% Note: the algebraic vector is sorted from left to right and down up.

    N  = sqrt(size(b,1));
    d = zeros(N+2,N+2);
    
    for j=2:N+1
        for i=2:N+1
            d(i,j) = b((i-1) + N*(j-2));
        end
    end
end