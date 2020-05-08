
clc;
close all;
clear all;
o=.1;
z=-.1;
a=[z z o o z z... 
   z z z o z z...
   z z z o z z...
   z z z o z z...
   z z o o o z];%1
b=[o o o o z z...
   z z z o z z...
   o o o o z z...
   o z z z z z...
   o o o o z z];%2
c=[z z o o o o...
   z z o z z z...
   z z o o o o...
   z z z z z o...
   z z o o o o];%5

a_ = [z o];
b_ = [o z];
c_ = [o o];

p1 = 15;
p2 = 20;
p3 = 10;

M = p1*a'*a_+p2*b'*b_+p3*c'*c_;

G_high = max(max(M));
G_low = min(min(M));
RM_high = 100e3;
RM_low = 10e3;
RN = RM_high - (RM_high*G_high)*(RM_high - RM_low)/(RM_high*G_high - RM_low*G_low);
RF = RN*(RM_high*G_high - RM_low*G_low)/(RM_high - RM_low);
RM=zeros(length(a),length(a_));
for i=1:length(a)
    for j=1:length(a_)
        RM(i,j) = RF*RN/(RF-M(i,j)*RN);
    end
end