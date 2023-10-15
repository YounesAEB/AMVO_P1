function plotConvectiveAndDiffusiveError(error,L,N)
% plotError plots the maximum error for the convective and diffusive terms against h^2.
% h = L/N 

    set(groot,'defaultAxesTickLabelInterpreter','latex');
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');

    
    h = L./N;
    
    figure()
    axes('XScale', 'log', 'YScale', 'log')
    hold on
    loglog(h,error(:,1),h,error(:,3),'Marker','o');
    loglog(h,h.^2);
    hold off
    legend('x-axis convective error','x-axis diffusive error','$h^2$','Location','southeast');
    xlabel('$h$')
    ylabel('error')
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize',16);
    grid on
    grid minor
    axis padded

    figure()
    axes('XScale', 'log', 'YScale', 'log')
    hold on
    loglog(h,error(:,2),h,error(:,4),'Marker','o');
    loglog(h,h.^2);
    hold off
    legend('y-axis convective error','y-axis diffusive error','$h^2$','Location','southeast');
    xlabel('$h$')
    ylabel('error')
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize',16);
    grid on
    grid minor
    axis padded
end