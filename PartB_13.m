%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part B  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
L  = 1; % domain size
N  = 8;

% Velocity fields computation
up = zeros(N+2,N+2);
up(3,3) = 1; % Imbalance, no null divergent condition
up = haloUpdate(up);

vp = zeros(N+2,N+2);
vp = haloUpdate(vp);

% Pseudo-pressure computation
[A] = computeMatrixA(N);
A1 = inv(A);
[d,pseudoP] = compute_pseudoP(up,vp,A1,L);
printField(d, 'divergence initial velocity ', ' %+.3e '); % Proof there are non-zero terms

% Next velocity computation
[un,vn] = computeNextVelocityField(up,vp,pseudoP,L);

% Null divergence proof of the new velocity field
[proof] = diverg(un,vn,L);
printField(proof, 'divergence next velocity ', ' %+.3e ');

% Post processing
plotVelocityField(up,vp,L);
plotVelocityField(un,vn,L);