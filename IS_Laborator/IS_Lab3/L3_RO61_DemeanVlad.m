%LABORATORUL 3

%ordin 1
clear;close all;
load("lab3_order1_3.mat")
%load("lab3_order2_3.mat")
%x1=x1{1};
%y1=y1{1};

x1 = data.InputData;
y1 = data.OutputData;

plot(x1)
figure
hold on
plot(t, y1)


uss = 3;
u0 = 0;

yss = 9.07;
y0 = 0.14;

y1 = y0 + (yss-y0)*0.632;

t2 = 2.94;
t1 = 0;

T = t2 - t1;
K = (yss - y0)/(uss - u0);
H = tf(K, [T 1]);

%yaprox = lsim(H, x1, t);
%plot(t, y1, t, yaprox);
%%
%ordinul 2

load('lab3_order2_3.mat')
x2 = data.InputData;
y2 = data.OutputData;

plot( x2);
figure
hold on
plot(t, y2)

uss1 = 2;
u01 = 0;

yss1 = 5.9; %de unde se stabilizeaza
y01 = 0;

ymax = 9.07; %maxim prima oscilatie
ymin = 7; %maxim a doua oscialtie

umax = 3.15; %coresp ymin/max
umin = 10; %coresp ymin/max

K = (yss1 - y01)/(uss1 - u01); %sa mai modific valorile

T = umin - umax;
M = (ymax - yss1)/yss1;
tita = -log(M)/sqrt(pi.^2+(log(M)).^2);
omega = 2*pi/T*(sqrt(1-(tita).^2));
H = tf(K*((omega)).^2, [1, 2*tita*omega, omega.^2]);
yaprox1 = lsim(H,x2,t);

plot(t, [x2, y2, yaprox1])
%%
%mse
p = y01-yaprox1;
val_mse = 0;
for i=1:length(y2)
   val_mse = val_mse+p(i).^2;
end

vald_mse1 = (1/(length(y2)))*sum(val_mse);

%figure
%plot(val_mse(y2))








