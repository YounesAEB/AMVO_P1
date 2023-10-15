function plotNumericAnalyticVelocity(time,u23,ua23,v23,va23,N,Qx,Qy)

set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

figure ()
hold on
plot(time,u23,time,v23,"LineStyle","--");
plot(time,ua23,time,va23);
hold off
legend('$u^n$','$v^n$','$u_{an}$','$v_{an}$')
title("N=" + N + " elements")
xlabel('time (s)')
ylabel("Velocity at point (" + Qx + "," + Qy +")")
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize',16);
grid on
grid minor
axis padded

end