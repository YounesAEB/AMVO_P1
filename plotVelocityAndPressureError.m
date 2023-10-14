function plotVelocityAndPressureError(L,Naux,errorVelocity,errorPressure)

set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

h = L./Naux;

figure ()
loglog(h,errorVelocity,"Marker","o");
hold on
loglog(h,errorPressure,"Marker","o");
loglog(h,h.*h);
legend('$error_{velocity}$','$error_{pressure}$','$h^2$',Location='northwest');
hold off

xlabel('h')
ylabel('error')
grid on
grid minor
axis padded

end