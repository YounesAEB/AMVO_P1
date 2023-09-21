function [F] = haloUpdate(F)
% halo_update(F)updates the F values of the halo cells
% F: field to be updated
% Written by: Group 13
% Note: function to be used with uniform meshes

    N           = size(F,1)-2; % mesh size
    F(:,N+2)    = F(:,2); % right-most column gets the first mesh column values
    F(:,1)      = F(:,N+1); % left-most column gets the last mesh column values
    F(N+2,:)    = F(2,:); % top row gets first mesh row values
    F(1,:)      = F(N+1,:); % bottom row gets last mesh row values
end