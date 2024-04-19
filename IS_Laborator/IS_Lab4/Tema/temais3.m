%set de date 2
%ordinul 1
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

ymax = 3.95;
yss = 2.99;

t2 = 5.40;
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
ygraph = lsim(H2,data.InputData,t,yss);

plot(t, ygraph)
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

uss = 1;
yss= 0.5;

%k0 = 2.66;%valori bune
%k1 = 3.8;%valori bune
%k2 = 4.8;%valori bune
 
k0 = 2.77;%valori bune
k1 = 3.5;%valori bune
k2 = 4.5;

Am = 0;
Ap = 0;

Ts = t(10)-t(9);
for i = k0:k1
        Ap = Ap + sum(y1(k0:k1)-yss);
   for j = k1:k2
        Am = Am + sum(yss-y1(k1:k2));

   end
end
Aminus = Ts*Am;
Aplus = Ts*Ap;
M = Aminus/Aplus;


thita = (-log(M))/sqrt(pi^2+log(M)^2);

t1 = 3.11;
t2= 5.33;

T = t2-t1;
omegan = 2*pi/(T*(sqrt(1-thita^2)));

K = yss/uss;
%Hss = tf(K*omegan,[1 2*thita*omegan omegan^2]);

A1 = [0 1; -omegan^2 -2*thita*omegan];
B1 = [0; K*omegan^2];
C1 = [1 0];
D1 = 0;

Hss= ss(A1, B1, C1, D1);

ygraph = lsim(Hss,data.InputData,t,[yss 0]);

plot(t, ygraph)

