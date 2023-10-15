function plotNumericAnalyticVelocity(time,uQ,uaQ,vQ,vaQ,N,Qx,Qy)

set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

figure ()
hold on
plot(time,uQ,time,vQ,"LineStyle","--");
plot(time,uaQ,time,vaQ);
hold off
legend('$u^n$','$v^n$','$u_{an}$','$v_{an}$')
title("N=" + N + " elements")
xlabel('time (s)')
ylabel("Velocity at point (" + Qx + "," + Qy +")")
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 16)
grid on
grid minor
axis padded

end