%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part A  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
N  = 3;
L  = 1;                % domain size
up = zeros(N+2,N+2);
vp = zeros(N+2,N+2);
up(3,3) = 1; % imbalance
[d] = diverg(up,vp,L);
[b] = field2vector(d);
[A] = computeMatrixA(N);
p=A\b;
[pseudo] = vector2field(p);
[gx,gy] = grad(pseudo,L);
un = up - gx;

