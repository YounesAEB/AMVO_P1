function plot_streamlines(x_m, y_m, u, v)
% plot_streamlines(x_m, y_m, u, v) plots the streamlines of the velocity
% field u,v
% Isaac Garcia, Alex Martinez, Pau Romeu, Adriana Vescovi 2021
% Input:
%   u,v = are the horizontal and vertical velocities
%   x_m,y_m = are the coordinates of each Control Volume
    
    N = size(x_m, 1);
    x_m(N, :) = 1;
    y_m(:, N) = 1;
    

    figure();
    streamslice(x_m(:,2), y_m(2,:)',u,v, 1.5);
    xlabel('x [m]');
    ylabel('y [m]');
    title('Streamlines of the resultant velocity field');
    axis equal;
    xlim([0 1]);
    ylim([0 1]);
    grid on;
    
    figure();
    module_v = sqrt(u.^2 + v.^2);
    s = surf(x_m(:,2), y_m(2,:)', module_v);
    colormap turbo;
    s.EdgeColor = 'none';
    shading interp;
    view(0,90);
    cb = colorbar;
    set(cb, 'YDir', 'reverse');
    grid on;
    axis equal;
    xlim([0 1]);
    ylim([0 1]);
    xlabel('x [m]');
    ylabel('y [m]');
    title('Module of the resultant velocity field')
    cb.Label.String = 'Absolute velocity (m/s)';
    
end

