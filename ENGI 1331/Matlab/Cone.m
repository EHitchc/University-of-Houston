function[v, sa] = Cone(h, r)
    s=sqrt(h.^2+r.^2);
    v = (pi().*r.^2.*h)./3;
    sa = pi().*r.*s+pi().*r.^2;
end