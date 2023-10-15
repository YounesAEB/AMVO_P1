function plotNumericAnalyticPressure(time,pQ,paQ,N,Qx,Qy)

set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

figure ()
hold on
plot(time,pQ,"LineStyle","--");
plot(time,paQ);
hold off
legend('$p^n$','$p^{an}$')
title("N=" + N + " elements")
xlabel('time (s)')
ylabel("Pressure at point (" + Qx + "," + Qy +")")
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 16)
grid on
grid minor
axis padded

end