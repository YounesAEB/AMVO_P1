function plotVelocityField (u,v,L)
% plotVelocityField plots a given 2D field [u,v].
% u: horizontal velocity
% v: vertical velocity
% L: domain size

    set(groot,'defaultAxesTickLabelInterpreter','latex');
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    
    N = size(u,1)-2;
    [xsu,ysu,xsv,ysv] = setCoordinates(N,L); %Coordinates associated to each component of the velocity field u and v
    
    figure();
    hold on;
    for i = linspace(0, 1, N+1)
        plot([i i], [0 L],'color', '#999999');
    end
    for i = linspace(0, 1, N+1)
        plot([0 L], [i i],'color', '#999999');
    end
    ysu = haloUpdate(ysu);
    quiver(xsu(1:N+1,2:N+1), ysu(1:N+1,2:N+1), u(1:N+1,2:N+1), zeros(N+1,N), 0, 'LineWidth', 1.5, 'color', '#f44336');
    
    xsv = haloUpdate(xsv);
    quiver(xsv(2:N+1,1:N+1), ysv(2:N+1,1:N+1), zeros(N,N+1), v(2:N+1,1:N+1), 0, 'LineWidth', 1.5, 'color', '#f44336');
 
    axis equal
    axis padded;
    title('Velocity field')
    xlabel('x (m)')
    ylabel('y (m)')
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize',16);
    hold off;
    grid on
    grid minor
end
