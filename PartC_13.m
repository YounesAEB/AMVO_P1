%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part C  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
Naux            = [8,16,32]; % mesh size
L               = 1; % domain size
rho             = 1.225; % density
errorVelocity   = zeros(size(Naux,2),1); % velocity error vector preallocation
errorPressure   = zeros(size(Naux,2),1); % pressure error vector preallocation
Re              = 100;   % Desired Reynolds number 

for i=1:size(Naux,2)
% Preliminary steps 
N                   = Naux(i);
h                   = L/N;   % Cell size
t                   = 0;     % Initial time
it                  = 1;     % Iterations counter;
pressure            = zeros(N+2,N+2,1);
[xsu,ysu,xsv,ysv]   = setCoordinates(N,L); % Staggered mesh coordinates

% Initial velocity condition
syms x y
u_sym    = cos(2*pi*x).*sin(2*pi*y);
v_sym    = -sin(2*pi*x).*cos(2*pi*y);
[un,vn]  = setVelocityField(u_sym,v_sym,xsu,ysu,xsv,ysv);
u_before = un; % Initially un = un-1
v_before = vn; % Initially vn = vn-1 

% Computation of the kinematic viscosity in order to Re=100
nu = (L*max(max(sqrt(un.^2+vn.^2))))/Re;

% Inverse matrix computation
[A] = computeMatrixA(N);
A1 = inv(A);

% Main algorithm
while t<=2
    % Time step calculation
    time_step = computeTimeStep(un,vn,L,nu);

    % Predictor velocities computation
    [Rnu,Rnv]                 = computeR(un,vn,L,nu);
    [Rnu_before,Rnv_before]   = computeR(u_before,v_before,L,nu);
    
    % Compute velocity predictor
    up = un + time_step*((3/2)*Rnu - (1/2)*Rnu_before);
    vp = vn + time_step*((3/2)*Rnv - (1/2)*Rnv_before);
   
    % Pseudo-pressure computation
    [d,pseudoP] = compute_pseudoP(up,vp,L);
    
    % Next velocity computation
    [u_next,v_next] = computeNextVelocityField(up,vp,pseudoP,L);
    p_next = (pseudoP*rho)/time_step;

    % To calculate the error with pn, pressure is saved in the next time
    pressure(:,:,it+1) = p_next;
    if it==1
        pressure(:,:,1) = p_next;    
    end
    
    % Analytic computation
    [u_an,v_an,p_an] = computeAnalyticalSolution(xsu,ysu,xsv,ysv,t,rho,nu);

    % Error calculation
    error_u(it) = max(max(abs(u_an-un)));
    error_v(it) = max(max(abs(v_an-vn)));

    % Pressure difference can be measured, no reference for the absolute pressure
    delta_pa = p_an-p_an(2,2);
    delta_pressure = pressure(:,:,it)-pressure(2,2,it);
    error_p(it) = max(max(abs(delta_pa-delta_pressure)));
    
    % Save information for post-process (saving just 1 coordinate information)
    Qx=4;
    Qy=4; % Position Q=(Qx,Qy) is the one going to be studied

    uQ(it)  = un(Qx,Qy);
    vQ(it)  = vn(Qx,Qy);
    uaQ(it) = u_an(Qx,Qy);
    vaQ(it) = v_an(Qx,Qy);
    pQ(it)  = delta_pressure(Qx,Qy);
    paQ(it) = delta_pa(Qx,Qy);
    time(it)= t;
    
    % Save information for next time-step
    u_before = un;
    v_before = vn;
    un       = u_next;
    vn       = v_next;
    
    % Next time instant
    it = it + 1;
    t  = t + time_step;
end

% Results plot for each N
plotNumericAnalyticVelocity(time,uQ,uaQ,vQ,vaQ,N,Qx,Qy);
plotNumericAnalyticPressure(time,pQ,paQ,N,Qx,Qy);

% Save data for post processing
errorVelocity(i) = max(max(error_u),max(error_v));
errorPressure(i) = max(error_p);

end

% POST PROCESSING
plotVelocityAndPressureError(L,Naux,errorVelocity,errorPressure);
plotStreamlines(un,vn,xsv,ysu); %Streamlines at final time instant and higher N
plotVelocityModule(un,vn,xsv,ysu); %Velocity modules at final time instant and higher N

