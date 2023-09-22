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

    syms x y
    u = cos(2*pi*x).*sin(2*pi*y);
    v = -sin(2*pi*x).*cos(2*pi*y);

    fcu_sym = u*diff(u,x)+v*diff(u,y);
    fcv_sym = u*diff(v,x)+v*diff(v,y);

    fdu_sym = diff(u,x,x)+diff(u,y,y);
    fdv_sym = diff(v,x,x)+diff(v,y,y);

    cu_sym = matlabFunction(fcu_sym, 'Vars', [x,y]);
    cv_sym = matlabFunction(fcv_sym, 'Vars', [x,y]);
    du_sym = matlabFunction(fdu_sym, 'Vars', [x,y]);
    dv_sym = matlabFunction(fdv_sym, 'Vars', [x,y]);

    cu_an = cu_sym(xsu,ysu);
    cv_an = cv_sym(xsv,ysv);

    du_an = du_sym(xsu,ysu);
    dv_an = dv_sym(xsv,ysv);
    
end