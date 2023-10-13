function [xsu,ysu,xsv,ysv] = setCoordinates(N,L)
% setCoordinates set the coordinates of the points associated to each
% velocity component u and v.
% xsu and ysu are the staggered coordinates associated to u.
% xsv and ysv are the staggered coordinates associated to v.

    xsu = zeros(N+2,N+2);
    ysu = zeros(N+2,N+2);
    xsv = zeros(N+2,N+2);
    ysv = zeros(N+2,N+2);
    h   = L/N; %for a uniform mesh

    for i = 2:N+1 
       for j = 2:N+1
           xsu(i,j) = h*(i-1);
           ysu(i,j) = h*(j-3/2); 
           xsv(i,j) = h*(i-3/2);
           ysv(i,j) = h*(j-1);
       end
    end
    
end