%programming pulse generator
function success=program_pulse_generator(R_T,filename)
dt = 1e-6;
NO_OF_iteration = 3000;
t=0:dt:NO_OF_iteration*dt;
T = t(1);
x0 = .11;
tolarance = 15;
R_target = R_T;
V = 50e-3;
% opening text file to write the pulse value
pwm_file = fopen(filename,'w');
% writing data to file
fwrite(pwm_file,num2str(T,'%0.5e'));
fwrite(pwm_file,' ');
fwrite(pwm_file,num2str(-V,'%0.5e'));
fprintf(pwm_file,'\n');


for i=1:length(t)
    [R(i),x0] = get_memristor_registance(V,dt,x0);
    dR = R_target - R(i);
    if abs(dR) < tolarance
        break;
    end
    V = -5*dR/R_target;
    
    if(V >= -.5 && V<=.6)
        V= -1;
    end
    % time sequence calculation
    T = T+dt;
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
