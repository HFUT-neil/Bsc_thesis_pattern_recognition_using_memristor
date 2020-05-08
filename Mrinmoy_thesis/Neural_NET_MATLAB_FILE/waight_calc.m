close all;
in1=[0 0 .1];
in2=[0 .1 .1];
in3=[.1 0 .1];
in4=[.1 .1 .1];
out=[ .8 1.2 1.7 -2.5];

in=[in1;in2;in3];
inv_in = inv(in);
w=inv_in *(out(1:3))';
%disp(w);
out4 = w'*in4'

R_N = 1.8182e+04;
R_F = 2.2222e+05;

R1 = R_mem(R_N,R_F,w(1))
R2 = R_mem(R_N,R_F,w(2))
R0 = R_mem(R_N,R_F,w(3))