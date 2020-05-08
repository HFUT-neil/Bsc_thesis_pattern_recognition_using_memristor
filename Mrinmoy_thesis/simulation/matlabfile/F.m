function f = F(v1,v2,xp,xn,alphap,alphan,eta)
if eta*v1 >= 0
    if v2 >= xp
        f=exp(-alphap*(v2-xp))*WP(v2,xp);
    else
        f = 1;
    end
else
    if v2 <= 1-xn
        f= exp(alphan*(v2+xn-1))*WN(v2,xn);
    else
        f=1;
    end
end
end