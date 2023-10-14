function [u_an,v_an,p_an] = computeAnalyticalSolution(xsu,ysu,xsv,ysv,t,rho,nu)

    u_an = exp(-8*pi*pi*nu*t)*cos(2*pi*xsu).*sin(2*pi*ysu);
    u_an = haloUpdate(u_an);

    v_an = exp(-8*pi*pi*nu*t)*-cos(2*pi*ysv).*sin(2*pi*xsv);
    v_an = haloUpdate(v_an);

    p_an = -rho*exp(-8*pi*pi*nu*t)*exp(-8*pi*pi*nu*t)*((cos(2*pi*xsv).^2)/2 + (cos(2*pi*ysu).^2)/2);
    p_an = haloUpdate(p_an);

end