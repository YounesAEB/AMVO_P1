function [cu_an,cv_an,du_an,dv_an] = computeAnalyticValues (xsu,xsv,ysu,ysv)
% computeAnalyticValues derivates and calculates the convective and diffusive
% term using the anal expressions
% TBD: symbolic calculation of the expressions
% Optional: Integral Calculation
% u: horizontal velocity field
% v: vertical velocity field
% N: mesh size
% L: domain size
% h: cell size

    cu_an = - 2*pi*cos(2*pi*xsu).*cos(2*pi*ysu).^2.*sin(2*pi*xsu) - 2*pi*cos(2*pi*xsu).*sin(2*pi*xsu).*sin(2*pi*ysu).^2; 
    cv_an = - 2*pi*cos(2*pi*xsv).^2.*cos(2*pi*ysv).*sin(2*pi*ysv) - 2*pi*cos(2*pi*ysv).*sin(2*pi*xsv).^2.*sin(2*pi*ysv);

    du_an = -8*pi^2*cos(2*pi*xsu).*sin(2*pi*ysu);
    dv_an = 8*pi^2*cos(2*pi*ysv).*sin(2*pi*xsv);
    
end