function g = G(V,An,Ap,vn,vp)
if V<=vp
    if V>=-vn
        g=0;
    else
        g=An*(exp(-V)-exp(vn));
    end
else
    g=Ap*(exp(V)-exp(vp));
end