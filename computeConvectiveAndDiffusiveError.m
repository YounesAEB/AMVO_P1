function [ecu,ecv,edu,edv] = computeConvectiveAndDiffusiveError(cu,cv,du,dv,cu_an,cv_an,du_an,dv_an,L)
% computeError computes the maximum error between the
% an and numeric solutions
% ecu: error in the convective term of the horizontal velocity
% ecv: error in the convective term of the vertical velocity
% edu: error in the diffusive term of the horizontal velocity
% edv: error in the diffusive term of the vertical velocity
    
    N = size(cu,1)-2;
    h = L/N;
    
    ecu = max(max(abs(cu_an-cu/h^2)));
    ecv = max(max(abs(cv_an-cv/h^2)));
    edu = max(max(abs(du_an-du/h^2)));
    edv = max(max(abs(dv_an-dv/h^2)));
end