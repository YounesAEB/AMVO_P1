function [d,pseudoP] = compute_pseudoP(up,vp,L)
% compute_pseudoP computes the pseudo-pressure value. Scalar field.
% up,vp: predictor velocity field
% L: domain size.

    N = size(up,1)-2;
    
    % Computation of the dirvegence of the predictor velocity
    d = diverg(up,vp,L); % Non-zero term 
    
    % From scalar field to algebraic vector
    b = field2vector(d);
    
    % Resolution of the equations system
    A = computeMatrixA(N);
    p = A\b;

    % From algebraic vector to scalar field
    pseudoP = vector2field(p);
    pseudoP = haloUpdate(pseudoP);
end