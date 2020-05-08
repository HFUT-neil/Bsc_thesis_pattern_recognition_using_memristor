clear all;
close all;
one = .1;
zero = -.1;
no_of_pattern = 11;
width = 18;
height = 20;
all_pattern = zeros(no_of_pattern,width*height);
bias_weight=zeros(1,no_of_pattern);
encoded_bit_number = 4;
M = zeros(width*height,encoded_bit_number);
for d=1:no_of_pattern
    filename=strcat('../database/small_font/Bengali_Letter_',num2str(d),'_20x18.jpg');
    img = imread(filename);
    %figure;
    %imshow(img);
    
    img = rgb2gray(img);
    %figure;
    %imshow(img);
    
    threshhold = 100;
    img = img>threshhold;
    %figure;
    %imshow(img);
    
    [row,col] = size(img);
    pattern = zeros(col,row);
    for i=1:row
        for j=1:col
            if img(i,j)==1
                pattern(j,i) = one;
            else
                pattern(j,i) = zero;
            end
        end
    end
    pattern = pattern(:);%conversion of matrix from 2D to 1D
    all_pattern(d,:)=pattern;
    bias_weight(d)=width*height/sum(sum(img));
    encode_num=dec2bin(d,encoded_bit_number);
    encoded_pattern = zeros(1,encoded_bit_number);
    for kk =1:encoded_bit_number
        if encode_num(kk) == '1'
            encoded_pattern(kk) = one;
        else
            encoded_pattern(kk) = zero;
        end
    end
    M = M +  bias_weight(d)*pattern*encoded_pattern;
end

%registance calculation
G_high = max(max(M));
G_low = min(min(M));
RM_high = 100e3;
RM_low = 10e3;
RN = RM_high - (RM_high*G_high)*(RM_high - RM_low)/(RM_high*G_high - RM_low*G_low);
disp('RN');
disp(RN);
RF = RN*(RM_high*G_high - RM_low*G_low)/(RM_high - RM_low);
disp('RF');
disp(RF);
[r,c] = size(M);
RM=zeros(r,c);
time = zeros(r,c);
dR = zeros(r,c);%programming error
for i=1:r
    for j=1:c
        RM(i,j) = RF*RN/(RF-M(i,j)*RN);
        filename=strcat('../pulse_file/R_',num2str(i),'_',num2str(j),'.txt');
        [t,dr] = program_pulse_generator(RM(i,j),filename);
        time(i,j)=t;
        dR(i,j) = dr;
    end
end
disp('max dR:');
disp(max(max(abs(dR))));
%test pulse addition
dt = .05e-6;
T = max(max(time))*dt+dt;
V = 0;
for i=1:r
    for j=1:c
        V = 0;
        filename=strcat('../pulse_file/R_',num2str(i),'_',num2str(j),'.txt');
        pwm_file = fopen(filename,'a');
        filename_RN=strcat('../pulse_file/R_N_',num2str(i),'_',num2str(j),'.txt');
        pwm_file_RN = fopen(filename_RN,'w');
        
        tt = T;
        for k=1:no_of_pattern
            %main pattern pulse
            fwrite(pwm_file,num2str(tt,'%0.5e'));
            fwrite(pwm_file,' ');
            fwrite(pwm_file,num2str(V,'%0.5e'));
            fprintf(pwm_file,'\n');
            %RN pulse
            fwrite(pwm_file_RN,num2str(tt,'%0.5e'));
            fwrite(pwm_file_RN,' ');
            fwrite(pwm_file_RN,num2str(V,'%0.5e'));
            fprintf(pwm_file_RN,'\n');
            
            tt = tt+dt;
            %main pattern pulse
            fwrite(pwm_file,num2str(tt,'%0.5e'));
            fwrite(pwm_file,' ');
            fwrite(pwm_file,num2str(all_pattern(k,i),'%0.5e'));
            fprintf(pwm_file,'\n');
            %RN pulse
            fwrite(pwm_file_RN,num2str(tt,'%0.5e'));
            fwrite(pwm_file_RN,' ');
            fwrite(pwm_file_RN,num2str(-all_pattern(k,i),'%0.5e'));
            fprintf(pwm_file_RN,'\n');
            
            
            tt = tt + dt*10e3;
            %main pattern pulse
            fwrite(pwm_file,num2str(tt,'%0.5e'));
            fwrite(pwm_file,' ');
            fwrite(pwm_file,num2str(all_pattern(k,i),'%0.5e'));
            fprintf(pwm_file,'\n');
            %RN pulse
            fwrite(pwm_file_RN,num2str(tt,'%0.5e'));
            fwrite(pwm_file_RN,' ');
            fwrite(pwm_file_RN,num2str(-all_pattern(k,i),'%0.5e'));
            fprintf(pwm_file_RN,'\n');
               
            
            tt = tt + dt;
            %main pattern pulse
            fwrite(pwm_file,num2str(tt,'%0.5e'));
            fwrite(pwm_file,' ');
            fwrite(pwm_file,num2str(V,'%0.5e'));
            fprintf(pwm_file,'\n');
            %RN pulse
            fwrite(pwm_file_RN,num2str(tt,'%0.5e'));
            fwrite(pwm_file_RN,' ');
            fwrite(pwm_file_RN,num2str(V,'%0.5e'));
            fprintf(pwm_file_RN,'\n');
            
            
            tt = tt + dt*10e3;
            %main pattern pulse
            fwrite(pwm_file,num2str(tt,'%0.5e'));
            fwrite(pwm_file,' ');
            fwrite(pwm_file,num2str(V,'%0.5e'));
            fprintf(pwm_file,'\n');
            %RN pulse
            fwrite(pwm_file_RN,num2str(tt,'%0.5e'));
            fwrite(pwm_file_RN,' ');
            fwrite(pwm_file_RN,num2str(V,'%0.5e'));
            fprintf(pwm_file_RN,'\n');
            
        end
        fclose(pwm_file);
        fclose(pwm_file_RN);
    end
end


