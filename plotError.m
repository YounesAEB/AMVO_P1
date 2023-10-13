function plotError(error,L,N)
% plotError plots the maximum error for the convective and diffusive terms against h^2.
% h = L/N 

    set(groot,'defaultAxesTickLabelInterpreter','latex');
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    
    h = L./N;
    
    figure()
    loglog(h,error(:,1),h,error(:,3),h,h.^2);
    legend('x-axis convective error','x-axis diffusive error','$h^2$','Location','southeast');
    xlabel('$h$')
    ylabel('error')
    grid on
    grid minor

    figure()
    loglog(h,error(:,2),h,error(:,4),h,h.^2);
    legend('y-axis convective error','y-axis diffusive error','$h^2$','Location','southeast');
    xlabel('$h$')
    ylabel('error')
    grid on
    grid minor
end