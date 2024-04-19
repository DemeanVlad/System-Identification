%set de date 2
clear; close all;
load('lab4_order1_2.mat')
%load('lab4_order2_2.mat')

x1 = data.InputData;
y1 = data.OutputData;

plot(t,x1)
figure
hold on
plot(t,y1)

uss = 2;

ymax = 3.96;
yss = 2.96; % = t1
t2 = 3.72;
t1 = 3.48;
yaprox = 0.368*(ymax-yss)+yss;

K = yss/uss;
T = t2 - t1;
H = tf(K, [T 1]);

A = (-1)/T;
B = K/T;
C = 1;
D = 0;

H2 = ss(A,B,C,D);
%yaprox1 = lsim(H2,data.InputData,t,yss);

plot(t, yaprox1);
%%
clear; close all;
%load('lab4_order1_2.mat')
load('lab4_order2_2.mat')

x1 = data.InputData;
y1 = data.OutputData;

plot(t,x1)
figure
hold on
plot(t,y1)
