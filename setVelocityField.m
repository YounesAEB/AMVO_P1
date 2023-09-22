function [u,v] = setVelocityField (xsu,ysu,xsv,ysv)
% set_velocity_field(N,L) creates a velocity field from an analytic
% velocity distribution
% u: horizontal velocity field
% v: vertical velocity field
% N: mesh size
% L: domain size
% h: cell size
% Note: assign the east and north values of the cells, starting at (2,2)

    u = cos(2*pi*xsu).*sin(2*pi*ysu);
    v = -sin(2*pi*xsv).*cos(2*pi*ysv);

    u = haloUpdate(u);
    v = haloUpdate(v);
end