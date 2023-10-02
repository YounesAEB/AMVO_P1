%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part C  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
Naux    = [10]; % mesh size
L       = 1;                % domain size
e       = zeros(size(Naux,2),1);
Re = 100;   % Desired Reynolds number 

for i=1:size(Naux,2)
% Preliminary steps 
N                   = Naux(i);
h                   = L/N;   % Cell size
t                   = 0;     % Initial time
it                  = 1;     % Iterations counter;
[xsu,ysu,xsv,ysv]   = setCoordinates(N,L); % Staggered mesh coordinates
while t<=2
%% Initial velocity condition
if t==0
syms x y
u_sym    = cos(2*pi*x).*sin(2*pi*y);
v_sym    = -sin(2*pi*x).*cos(2*pi*y);
[un,vn]  = setVelocityField(u_sym,v_sym,xsu,ysu,xsv,ysv);
u_before = un; % Initially un = un-1
v_before = vn; % Initially vn = vn-1 

nu = (L*max(max(max(un,vn))))/Re; % Kinematic viscosity to obtain desired Re
end    
%% Time step calculation
time_step = computeTimeStep(un,vn,L,nu);
%% Predictor velocities computation
[Rnu,Rnv]                 = computeR(un,vn,L,nu);
[Rnu_before,Rnv_before]   = computeR(u_before,v_before,L,nu);

up = un + time_step*((3/2)*Rnu - (1/2)*Rnu_before);
vp = vn + time_step*((3/2)*Rnv - (1/2)*Rnv_before);
up = haloUpdate(up);
vp = haloUpdate(vp);
%% Next step velocity field calculation
[d] = diverg(up,vp,L);
% Prove the predictor velocity field has non-zero divergence
[predictor_proof] = d;
if max(max(abs(predictor_proof)))<1e-10
    disp('ERROR: PREDICTOR VELOCITY NON-ZERO DIVERGENCE NOT PROVED');
    break
end
% printField(d,'up divergenge','%+.3e ');
[b] = field2vector(d);
[A] = computeMatrixA(N);
p=A\b;
[pseudo_p] = vector2field(p);
pseudo_p = haloUpdate(pseudo_p);
[gx,gy] = grad(pseudo_p,L);
gx = haloUpdate(gx);
gy = haloUpdate(gy);
u_next = up - gx;
u_next = haloUpdate(u_next);
v_next = vp - gy;
v_next = haloUpdate(v_next);

% Prove the next step velocity field has zero divergence
[proof] = diverg(u_next,v_next,L);
if max(max(abs(proof)))>1e-10
    disp('NEXT STEP ZERO DIVERGENCE NOT PROVED');
    break
end

% Analytic computation
ua = exp(-8*pi*pi*nu*t)*cos(2*pi*xsu).*sin(2*pi*ysu);
ua = haloUpdate(ua);
va = exp(-8*pi*pi*nu*t)*-cos(2*pi*ysv).*sin(2*pi*xsv);
va = haloUpdate(va);
% Error calculation
error_u(it) = max(max(abs(ua-un)));
error_v(it) = max(max(abs(va-vn)));
% Save information for post-process (saving just 1 coordinate information)
u(it)    = un(3,3);
v(it)    = vn(3,3);
u3(it)   = exp(-8*pi*pi*nu*t)*cos(2*pi*xsu(3,3))*sin(2*pi*ysu(3,3));
v3(it)   = exp(-8*pi*pi*nu*t)*-cos(2*pi*ysv(3,3))*sin(2*pi*xsv(3,3));
time(it) = t;
% Save information for next time-step
u_before = un;
v_before = vn;
un       = u_next;
vn       = v_next;

it = it + 1;
t  = t + time_step;
end
figure ()
plot(time,u,time,u3);
hold on
plot(time,v,time,v3);
hold off
e(i) = max(max(error_u),max(error_v));
end

%% POST PROCESSING
tamany = L./Naux;
figure ()
loglog(tamany,e);
hold on
loglog(tamany,tamany.*tamany);

