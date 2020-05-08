clear all;
close all;
in1=[-.1 -.1 .1];
in2=[-.1 .1 .1];
in3=[.1 -.1 .1];
in4=[.1 .1 .1];
%gate = 'AND';
%gate = 'OR';
gate = 'NOR';
%gate = 'NAND';
if strcmp(gate,'AND')
    out=[ -1.8 -.75 -.65 .4];
elseif strcmp(gate,'OR')
    out=[ -0.9 0.75 0.15 1.8];
elseif strcmp(gate,'NOR')
    out=[ .9 -.75 -.15 -1.8];
elseif strcmp(gate,'NAND')
    out=[ 1.9 .75 .55 -.6];
end

in=[in1;in2;in3];
%inv_in = inv(in);
%w=inv_in *(out(1:3))'
w = in \(out(1:3))';
%disp(w);
out4 = w'*in4'

R_N = 1.8182e+04;
R_F = 2.2222e+05;

%R1 = R_mem(R_N,R_F,w(1));
%R2 = R_mem(R_N,R_F,w(2));
%R0 = R_mem(R_N,R_F,w(3));

time = zeros(1,length(w));
for i=1:length(w)
    R_T = R_mem(R_N,R_F,w(i));
    time(i) = program_pulse_generator(R_T,strcat('R_',num2str(i),'.txt'));
end
disp(max(time));