function [d,pseudoP] = compute_pseudoP(up,vp,A1,L)
% compute_pseudoP computes the pseudo-pressure value. Scalar field.
% up,vp: predictor velocity field
% L: domain size.
    
    % Computation of the dirvegence of the predictor velocity
    d = diverg(up,vp,L); % Non-zero term 
    
    % From scalar field to algebraic vector
    b = field2vector(d);
    
    % Resolution of the equations system
    p = A1*b;

    % From algebraic vector to scalar field
    pseudoP = vector2field(p);
    pseudoP = haloUpdate(pseudoP);
end