%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part C  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
Naux    = [8,16,32]; % mesh size
L       = 1;                % domain size
rho     = 1.225; % density
e       = zeros(size(Naux,2),1); % velocity error vector preallocation
ep      = zeros(size(Naux,2),1); % pressure error vector preallocation
Re = 100;   % Desired Reynolds number 

for i=1:size(Naux,2)
% Preliminary steps 
N                   = Naux(i);
h                   = L/N;   % Cell size
t                   = 0;     % Initial time
it                  = 1;     % Iterations counter;
pressure            = zeros(N+2,N+2,1);
[xsu,ysu,xsv,ysv]   = setCoordinates(N,L); % Staggered mesh coordinates
[A] = computeMatrixA(N);
A1 = inv(A);
while t<=2
%% Initial velocity condition
if t==0
syms x y
u_sym    = cos(2*pi*x).*sin(2*pi*y);
v_sym    = -sin(2*pi*x).*cos(2*pi*y);
[un,vn]  = setVelocityField(u_sym,v_sym,xsu,ysu,xsv,ysv);
u_before = un; % Initially un = un-1
v_before = vn; % Initially vn = vn-1 

nu = (L*max(max(max(abs(un),abs(vn)))))/Re; % Kinematic viscosity to obtain desired Re
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
elseif max(max(abs(predictor_proof)))>=1e-10
    disp('PREDICTOR VELOCITY NON-ZERO DIVERGENCE PROVED');
    disp('Minimum Absolute Value of the Divergence:');
    disp(max(max(abs(predictor_proof))));
end
% printField(d,'up divergenge','%+.3e ');
[b] = field2vector(d);
p=A1*b;
[pseudo] = vector2field(p);
pseudo = haloUpdate(pseudo);
[gx,gy] = grad(pseudo,L);
gx = haloUpdate(gx);
gy = haloUpdate(gy);
u_next = up - gx;
u_next = haloUpdate(u_next);
v_next = vp - gy;
v_next = haloUpdate(v_next);
p_next = (pseudo*rho)/time_step;
%To calculate the error with pn, pressure is saved in the next time
pressure(:,:,it+1) = p_next;
if it==1
    pressure(:,:,1) = p_next;    
end

% Prove the next step velocity field has zero divergence
[proof] = diverg(u_next,v_next,L);
if max(max(abs(proof)))>1e-10
    disp('ERROR: NEXT STEP ZERO DIVERGENCE NOT PROVED');
    break
elseif max(max(abs(proof)))<=1e-10
    disp('NEXT STEP ZERO DIVERGENCE PROVED');
    disp('Maximum Absolute Value of the Divergence:');
    disp(max(max(abs(proof))));
end

% Analytic computation
ua = exp(-8*pi*pi*nu*t)*cos(2*pi*xsu).*sin(2*pi*ysu);
ua = haloUpdate(ua);
va = exp(-8*pi*pi*nu*t)*-cos(2*pi*ysv).*sin(2*pi*xsv);
va = haloUpdate(va);
pa = -rho*exp(-8*pi*pi*nu*t)*exp(-8*pi*pi*nu*t)*((cos(2*pi*xsv).^2)/2 + (cos(2*pi*ysu).^2)/2);
pa = haloUpdate(pa);
% Error calculation
error_u(it) = max(max(abs(ua-un)));
error_v(it) = max(max(abs(va-vn)));
% Pressure difference can be measured, no reference for the absolute pressure
delta_pa = pa-pa(2,2);
delta_pressure = pressure(:,:,it)-pressure(2,2,it);
error_p(it) = max(max(abs(delta_pa-delta_pressure)));

% Save information for post-process (saving just 1 coordinate information)
u23(it)    = un(2,3);
v23(it)    = vn(2,3);
ua23(it)   = ua(2,3);
va23(it)   = va(2,3);
p23(it)   = delta_pressure(2,3);
pa23(it)  = delta_pa(2,3);
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
plot(time,u23,time,ua23);
hold on
plot(time,v23,time,va23);
hold off

figure ()
plot(time,p23,time,pa23);

e(i)    = max(max(error_u),max(error_v));
ep(i)   = max(error_p);
end

%% POST PROCESSING
tamany = L./Naux;
figure ()
loglog(tamany,e);
hold on
loglog(tamany,tamany.*tamany);
loglog(tamany,ep);
legend('e_vel','h^2','e_press');


