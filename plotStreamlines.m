function plotStreamlines(u,v,xsv,ysu)
% To plot the streamlines of the velocity field u,v
% xc = xsv, yc = ysu
% Group 13, 2023.
    
    xc      = xsv;
    yc      = ysu;
    N       = size(xc, 1);
    xc(N,:) = 1;
    yc(:,N) = 1;
    

    figure();
    streamslice(xc(:,2), yc(2,:)',u,v, 1.5);
    xlabel('x [m]');
    ylabel('y [m]');
    title('Streamlines of the resultant velocity field');
    axis equal;
    xlim([0 1]);
    ylim([0 1]);
    grid on;
    
    figure();
    module_v = sqrt(u.^2 + v.^2);
    s = surf(xc(:,2), yc(2,:)', module_v);
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