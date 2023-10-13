function [un,vn] = computeNextVelocityField(up,vp,pseudoP,L)

    [gx,gy] = grad(pseudoP,L);
    gx = haloUpdate(gx);
    gy = haloUpdate(gy);

    un = up - gx;
    un = haloUpdate(un);

    vn = vp - gy;
    vn = haloUpdate(vn);
end