%LABORATORUL 4
%ordinul 1
clear;close all;
load('lab4_order1_2.mat')
%load("lab4_order2_2.mat")

x = data.InputData;
y = data.OutputData;

plot(t,x)
figure
hold on
plot(t,y)

%valorile de pe grafic
uss = 2;

ymax = 3.95;
yss = 2.99;

t2 = 5.28;
t1 = 3.48;

yaprox = 0.368*(ymax-yss)+yss;

K = yss/uss;
T = t2-t1;
H = tf(K, [T 1]);

A = -1/T;
B = K/T;
C = 1;
D = 0;

H2 = ss(A, B, C, D);
ygraph = lsim(H2, data.InputData,t,yss);

plot(t, ygraph)
%%
close; clear all;
load('lab4_order2_2.mat')

x = data.InputData;
y = data.OutputData;

plot(x)
figure
hold on
plot(t, y)

uss = 1;
yss = 0.5;

k0 = 30;
k1 = 44;
k2 = 56;

Am = 0;
Ap = 0;

Ts= t(25)-t(24);
 for i = k0:k1
    Ap = Ap + (y(i)-yss);
 end
  for j = k1:k2
         Am = Am + (yss-y(j));
  end


Aminus = Ts * Am;
Aplus = Ts * Ap;

M = Aminus/Aplus;

thita = (-log(M))/(sqrt(pi^2+log(M)^2));

t1 = 3.11;
t2 = 5.33;
T = t2-t1;

omegan = (2*pi)/(T*(sqrt(1-thita^2)));

K = yss/uss;

A = [ 0 1; -omegan^2 -(2*thita*omegan)];
B = [0; K*omegan^2];
C = [1 0];
D = 0;

Hss = ss(A,  B, C, D);
ygraph = lsim(Hss, data.InputData,t,[yss 0]);

plot(t, ygraph)














