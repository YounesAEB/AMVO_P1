function [d] = diverg(u,v,L)
% diverg(u,v,L) computes the divergence of a vectorial field with a
% staggered mesh to a centered scalar field.
% Written by: Group 13
% Note: the staggered mesh sets the velocity values at the walls of the
% centered mesh

    N = size(u,1)-2;
    d = zeros(N+2,N+2);
    h = L/N;

    for j=2:N+1
        for i=2:N+1
            up      = u(i,j);
            uw      = u(i-1,j);
            vp      = v(i,j);
            vs      = v(i,j-1);
            d(i,j)  = h*(vp-vs+up-uw);
        end
    end
end