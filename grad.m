function [gx,gy] = grad(s,L)
% grad(s) computes the gradient of a scalar field with a
% centered mesh to a staggered vectorial field.
% Written by: Group 13
% Note: the gradient values are set at the walls of the
% centered mesh

    N  = size(s,1)-2;
    h  = L/N;
    gx = zeros(N+2,N+2);
    gy = zeros(N+2,N+2);
    
    for j=2:N+1
        for i=2:N+1
            gx(i,j) = (s(i+1,j) - s(i,j))/h;
            gy(i,j) = (s(i,j+1) - s(i,j))/h;
        end
    end
end