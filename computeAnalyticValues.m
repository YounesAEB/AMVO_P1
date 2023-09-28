function [cu_an,cv_an,du_an,dv_an] = computeAnalyticValues (u_sym,v_sym,xsu,xsv,ysu,ysv)
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

%     cu_sym = u_sym*diff(u_sym,x)+v_sym*diff(u_sym,y);
%     cv_sym = u_sym*diff(v_sym,x)+v*diff(v_sym,y);
    cu_sym = diff(u_sym*u_sym,x)+diff(u_sym*v_sym,y);  % conservative
    cv_sym = diff(v_sym*u_sym,x)+diff(v_sym*v_sym,y);  % conservative

    du_sym = diff(u_sym,x,x)+diff(u_sym,y,y);
    dv_sym = diff(v_sym,x,x)+diff(v_sym,y,y);

    cu_disc = matlabFunction(cu_sym, 'Vars', [x,y]); % continuous to discrete
    cv_disc = matlabFunction(cv_sym, 'Vars', [x,y]); % continuous to discrete
    du_disc = matlabFunction(du_sym, 'Vars', [x,y]); % continuous to discrete
    dv_disc = matlabFunction(dv_sym, 'Vars', [x,y]); % continuous to discrete

    cu_an = cu_disc(xsu,ysu); % analitic assignment
    cv_an = cv_disc(xsv,ysv); % analitic assignment

    du_an = du_disc(xsu,ysu); % analitic assignment
    dv_an = dv_disc(xsv,ysv); % analitic assignment
    
end