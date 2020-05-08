function G=gain_cal(R_N,R_F,RM)
G=R_F*(1/R_N-1/RM);
end