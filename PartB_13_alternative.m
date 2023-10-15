%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part B  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
L  = 1; % domain size
N  = [1:100];
maxdiv = zeros(100,1);
for k=1:100
% Velocity fields computation
up = zeros(N(k)+2,N(k)+2);
up(3,3) = 1; % Imbalance, no null divergent condition
up = haloUpdate(up);

vp = zeros(N(k)+2,N(k)+2);
vp = haloUpdate(vp);

% Pseudo-pressure computation
[A] = computeMatrixA(N(k));
A1 = inv(A);
[d,pseudoP] = compute_pseudoP(up,vp,A1,L);
printField(d, 'divergence initial velocity field ', ' %+.3e '); % Proof there are non-zero terms

% Next velocity computation
[un,vn] = computeNextVelocityField(up,vp,pseudoP,L);

% Null divergence proof of the new velocity field
[proof] = diverg(un,vn,L);
printField(proof, 'divergence next velocity field', ' %+.3e ');

% Post processing
% plotVelocityField(up,vp,L);
% plotVelocityField(un,vn,L);
maxdiv(k)=max(max(abs(proof)));
end
figure ()
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');


plot(N(3:end),maxdiv(3:end))

xlabel('N')
ylabel('Maximum absolute value of $\nabla\cdot u^{n+1}$')
grid on
grid minor
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize',16);
axis padded