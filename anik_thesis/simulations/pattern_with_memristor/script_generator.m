k = 1;
for i=1:30
    for j=1:2
    %R_T = R_mem(R_N,R_F,w(i));
    time(k) = program_pulse_generator(RM(i,j),strcat('R_',num2str(i),num2str(j),'.txt'));
    k = k+1;
    end;
end



