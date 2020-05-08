
close all;
clear all;
out = [1 -1 -1 -1]';
out1=[1];
in1 = {-1 -1 1}';
in2 = {-1 1 1}';
in3 = {1 -1 1}';
in4 = {1 1 1}';
in=[in1 in2 in3 in4];


num_input = 3;
num_layer = 1;
bias_connect=[1];
input_connect=[1 1 1];
layer_connect = [0];
output_connect = [1];

net = network(num_input,num_layer,...
    bias_connect,input_connect,layer_connect,...
    output_connect);
%view(net);
net.layers{1}.size = 1;
net.layers{1}.transferFcn = 'hardlim';
%view(net);

net = configure(net,in1,out1);

%view(net);

initial_output = net(in1);

net.trainFcn = 'trainlm';
net.performFcn = 'mse';
%net = train(net,in,out);
%final_output = net(inputs);

