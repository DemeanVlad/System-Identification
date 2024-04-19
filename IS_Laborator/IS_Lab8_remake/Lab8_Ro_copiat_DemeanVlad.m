clear all;clc;close all;

load('datemotor.mat')
%plot(u)
%figure
%plot(vel)

yid1 = vel(1:211);
yval = vel(211:end);
y_max = vel(1:end);

uid1 = u(1:211);
uval = u(211:end);
u_max= u(1:end);

%N = length(uid1);
N = 200;
L = 1000;
alpha = 0.1;
% de lucrat la thetha 2
%thehta2 = [2, 2];
theta1 = [0.1; 3000];
theta0 = [1;1];
d = 10e-5;
%d = 0,000001;
l = 0 ;
Ts = 0.01 ;
nk = 2;


while (l<=L)
    e = zeros(1,N);
    dd = zeros(1,N);
   db = zeros(1,N);
   b = theta1(2,1);
   f = theta1(1,1);
   %schimb aici
    for i = 1 : N
       if i <= nk
           e(i) = yid1(i);
           df = 0;
           db(i) = 0;
       else
%nu mi da numa pt nk = 1
e(i) = yid1(i)+f*yid1(i-1)-b*uid1(i-nk)- ... 
    f*e(i-1);
dd(i) = yid1(i-1)-e(i-1)-f*dd(i-1);
db(i) = -uid1(i-nk)-f*db(i-1);
       end
    end 

   %urmeaza calculul gradientului

    de = [dd;db];
    dv = zeros(2,1);
    for i = 1 : N
        dv = dv + e(i)*de(:,i); 
    end
    dv = 2/(N-nk)*dv;
%urmeaza de calculat hessianului
 
    H = zeros(2,2);
    for i = 1 : N
        H = H + de(:,i)*(de(:,i))';
    end
    H = 2/(N-nk)*H;
    l = l + 1;
    theta0 = theta1;
    theta1 = theta0 - alpha*inv(H)*dv;
    
    if (norm(theta1-theta0)<d)
        break
    end
end

%b = theta1(2);
%f = theta1(1);
A = 1;
B = [0 0 theta1(2,1)];
C = 1;
D = 1;
F = [1 theta1(1, 1)];

modelOE = idpoly(A,B,C,D,F, 0, Ts);
modelVel = iddata(yval', uval, Ts);
%compare(modelOE,modelVel);
compare(modelOE,modelVel)