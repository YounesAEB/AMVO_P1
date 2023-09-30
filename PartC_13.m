%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part C  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
N = 3;
L = 1;                % domain size
h = L/N;
[xsu,ysu,xsv,ysv]   = setCoordinates(N,L);
% Initial velocity condition
syms x y
u_sym = 10*cos(2*pi*x).*sin(2*pi*y);
v_sym = -sin(2*pi*x).*cos(2*pi*y);
[u,v]               = setVelocityField(u_sym,v_sym,xsu,ysu,xsv,ysv);
un = u;
vn = v;
u_before = un; % Initially un = un-1
v_before = vn; % Initially vn = vn-1

time_step = 0.0001;
it = 1; % Iterations counter;

for t=1:time_step:10
%% Predictor velocities computation
[Rnu,Rnv]       = computeR(un,vn,L);
[Rnu_before,Rnv_before]   = computeR(u_before,v_before,L);

up = un + time_step*((3/2)*Rnu - (1/2)*Rnu_before);
vp = vn + time_step*((3/2)*Rnv - (1/2)*Rnv_before);
up = haloUpdate(up);
vp = haloUpdate(vp);

%% Next step velocity field calculation
[d] = diverg(up,vp,L);
[b] = field2vector(d);
[A] = computeMatrixA(N);
p=A\b;
[pseudo_p] = vector2field(p);
pseudo_p = haloUpdate(pseudo_p);
[gx,gy] = grad(pseudo_p,L);
gx = haloUpdate(gx);
gy = haloUpdate(gy);
unext = up - gx;
unext = haloUpdate(unext);
vnext = vp - gy;
vnext = haloUpdate(vnext);
[proof] = diverg(unext,vnext,L);
comprovar(:,:,it) = proof(:,:);
% Save information for next time-step
u_before = un;
v_before = vn;
un = unext;
vn = vnext;
it = it + 1;
end
