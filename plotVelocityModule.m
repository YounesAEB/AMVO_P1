function plotVelocityModule(un,vn,xsv,ysu)
% Plots the module of the velocity field u,v
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
Vmodule = sqrt(un.^2+vn.^2);
s = surf(xc(:,2),yc(2,:)',Vmodule);
colormap turbo;
s.EdgeColor = 'none';
shading interp;
view(0,90);
c = colorbar;
set(c,'YDir','reverse');
xlabel('$x (m)$');
ylabel('$y (m)$');
title('Velocity field module')
c.Label.String = 'Velocity module (m/s)';
c.Label.Interpreter = 'latex';
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 16)
grid on
grid minor
axis equal;
xlim([0 1]);
ylim([0 1]);

end
    