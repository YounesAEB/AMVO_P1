function [u,v] = setVelocityField (u_sym,v_sym,xsu,ysu,xsv,ysv)
% setVelocityField(N,L) creates a velocity field from an analytic
% velocity distribution
% u: horizontal velocity field
% v: vertical velocity field
% N: mesh size
% L: domain size
% h: cell size

    syms x y 
    u_disc = matlabFunction(u_sym, 'Vars', [x,y]); % continuous to discrete
    v_disc = matlabFunction(v_sym, 'Vars', [x,y]); % continuous to discrete
    u = u_disc(xsu,ysu); % numeric assigment
    v = v_disc(xsv,ysv); % numeric assigment

    u = haloUpdate(u);
    v = haloUpdate(v);
end