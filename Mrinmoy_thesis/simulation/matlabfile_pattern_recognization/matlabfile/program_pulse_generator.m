%programming pulse generator
function [success,dR]=program_pulse_generator(R_T,filename)
dt = .05e-6;
NO_OF_iteration = 50000;
t=0:dt:NO_OF_iteration*dt;
T = t(1);
x0 = .11;
tolarance = 10;
R_target = R_T;
V = 50e-3;
% opening text file to write the pulse value
pwm_file = fopen(filename,'w');
% writing data to file
fwrite(pwm_file,num2str(T,'%0.5e'));
fwrite(pwm_file,' ');
fwrite(pwm_file,num2str(-V,'%0.5e'));
fprintf(pwm_file,'\n');

p_i = 0;
kk=0;
for i=1:length(t)
    if p_i == 2 || p_i == 3
        V = .1;
        if p_i ==2
            dt = .005e-6;
        else
            dt = .05e-6;
        end
        p_i=p_i+1;
        if p_i == 4
            p_i = 0;
        end
    else
        V = -3;
        if p_i ==0
            dt = .005e-6;
        else
            dt = .05e-6;
        end
        p_i=p_i+1;
    end
    [R(i),x0] = get_memristor_registance(V,dt,x0);
    %disp(R(i));
    dR = R_target - R(i);
    %disp(dR)
    if dR < tolarance
        %disp(dR)
        kk=kk+1;
        if kk == 800
            break;
        end
    end
    
    
    % time sequence calculation
    T = T+dt;
    %disp(T);
    % writing data to file
    fwrite(pwm_file,num2str(T,'%0.5e'));
    fwrite(pwm_file,' ');
    fwrite(pwm_file,num2str(V,'%0.5e'));
    fprintf(pwm_file,'\n');
    
end
% last reading value of the pulse
T = T+dt;
V = 50e-3;
% writing data to file
fwrite(pwm_file,num2str(T,'%0.5e'));
fwrite(pwm_file,' ');
fwrite(pwm_file,num2str(V,'%0.5e'));
fprintf(pwm_file,'\n');
% closing file
fclose(pwm_file);

%plot(t(1:length(R)),R);
%title('Rm vs time ');
%xlabel('Time is second');
%ylabel('Registance in ohm');
%R_max = max(R);
success = length(R);
end
