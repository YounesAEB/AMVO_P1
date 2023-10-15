function plotStreamlines(un,vn,xsv,ysu)
% Plots the streamlines of the velocity field u,v
% xc = xsv, yc = ysu
% Group 13, 2023.
    
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

xc      = xsv;
yc      = ysu;
N       = size(xc,1);
xc(N,:) = 1;
yc(:,N) = 1;


figure();
streamslice(xc(:,2),yc(2,:),un,vn, 1.5);
xlabel('$x (m)$');
ylabel('$y (m)$');
title('Velocity field streamlines');
axis equal;
xlim([0 1]);
ylim([0 1]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 16)
grid on
grid minor
axis padded;

end