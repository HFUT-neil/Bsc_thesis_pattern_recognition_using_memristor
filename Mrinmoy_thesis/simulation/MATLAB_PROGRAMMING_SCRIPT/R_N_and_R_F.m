close all;
RM_H=100e3;
RM_L=10e3;
G_H=10;
G_L=-10;

R_N = (RM_L*RM_H/(G_H*RM_H - G_L*RM_L))...
    *(G_H-G_L);
R_F = (RM_L*RM_H*(G_H-G_L))/(RM_H-RM_L);

disp(R_N);
disp(R_F);