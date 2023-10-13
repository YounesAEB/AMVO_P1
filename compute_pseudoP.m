function [d,pseudoP] = compute_pseudoP(up,vp,L)
% compute_pseudoP computes 

    N = size(up,1)-2;
    d = diverg(up,vp,L); % Non-zero term 
    b = field2vector(d);
    A = computeMatrixA(N);
    p = A\b;
    pseudoP = vector2field(p);
    pseudoP = haloUpdate(pseudoP);
end