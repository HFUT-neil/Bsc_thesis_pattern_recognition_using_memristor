function ivrel = IVrel(v1,v2,a1,a2,b)
if v1 >= 0
    ivrel = a1*v2*sinh(b*v1);
else
    ivrel = a2*v2*sinh(b*v1);
end
end