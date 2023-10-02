%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part B  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
N  = 3; 
L  = 1; % domain size


% Impose vectorial fields
up      = zeros(N+2,N+2);
up(2,3) = 1; % Introduce imbalance
vp      = zeros(N+2,N+2);
vp      = haloUpdate(vp);
up      = haloUpdate(up);


% Discretization of the Poisson equation for the pseudo-p
[d] = diverg(up,vp,L);
[b] = field2vector(d);
[A] = computeMatrixA(N);
p   = A\b;
[pseudo] = vector2field(p);
pseudo   = haloUpdate(pseudo);

% Gradient of the pseudo-p
[gx,gy] = grad(pseudo,L);
gx = haloUpdate(gx);
gy = haloUpdate(gy);

% Updated velocity fields
un = up - gx;
un = haloUpdate(un);
vn = vp - gy;
vn = haloUpdate(vn);

% Proof
[proof] = diverg(un,vn,L);
