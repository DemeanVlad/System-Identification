clear all
close all
clc

load('datemotor.mat');
yid = id.y;
uid = id.u;
yval = val.y;
uval = val.u;
L = 150;
alpha = 0.5;
theta1 = [1,1]; %[f,b] thetha1(1) = f thetha1(2) = b
d = 10e-5;
theta0 = [0,0];
l = 0;
N = length(yid);
while (norm(theta1-theta0)>=d || l<=L)
    e = zeros(1,N);
    df = zeros(1,N);
    db = zeros(1,N);
    for i = 1 : N
       if i == 1
           e(i) = yid(i);
           df = 0;
           db = 0;
       else
e(i) = yid(i)+theta1(1)*yid(i-1)-theta1(2)*uid(i-1)-theta1(1)*e(i-1);
df(i) = yid(i-1)-theta1(1)*df(i-1)-e(i-1);
db(i) = -uid(i-1)-theta1(1)*db(i-1);
       end
    end
    de = [df;db];
    dv = zeros(2,2);
    for i = 1 : N
        dv = dv + e(i)*de(:,i); 
    end
    dv = 2/N*dv;
    H = zeros(2,1);
    for i = 1 : N
        H = H + de(:,i)*(de(:,i))';
    end
    H = 2/N*H;
    l = l + 1;
    theta0 = theta1;
    theta1 = theta1 - alpha*inv(H)*dv;
end
b = theta1(2);
f = theta1(1);
OE = idpoly(1,[0 b],1,1,[1 f],0,id.ts);
compare(OE,val);


