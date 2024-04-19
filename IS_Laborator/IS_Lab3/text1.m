%setul de date 3
%ordin 1
clear; close all;
load('lab3_order1_3')
%load('lab3_order2_3')
%x1=x1{1};
%y1=y1{1};
x1 = data.InputData;
y1 = data.OutputData;


%plot(x1)
figure
hold on
plot(t, y1)

uss = 3;
u0 = 0;

yss = 9;
y0 = 0;
y1 = y0 +(yss-y0)*0.632;

% y1 = 5.80 citim t2
t2 = 2.94; %aici sa mai vad ce si cum
t1 = 0;

T = t2 - t1;
K = (yss-y0)/(uss-u0);
H = tf(K, [T 1]);
yaprox = lsim(H,x1,t);

plot(t, y1, t, yaprox);