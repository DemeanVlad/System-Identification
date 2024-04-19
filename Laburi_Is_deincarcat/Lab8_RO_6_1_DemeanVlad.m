clear all;close all;
 
load('datemotor.mat')
%plot(u)
%figure
%plot(vel)
 
yid1 = vel(1:208); yval = vel(210:end);
uid1 = u(1:210); uval = u(210:end);
 
 
ts = 0.01;
nk = 2;
 
L_maxim = length(uid1);
L_minim = 0;
alpha = 0.1;
theta0 = [1; 1];
N = length(yid1);

    
while(L_minim<N)
    b = theta0(2);
    f = theta0(1);
    de_f = zeros(1,N);
    de_b = zeros(1,N);
    e(1:nk)=vel(1:nk);
    for i = nk+1:N
        e(i) = yid1(i) + theta0(1)*yid1(i-1)- theta0(2)*u(i-nk)-theta0(1)*e(i-1);
        de_f(i) =yid1(i-1)-e(i-1)-theta0(1)*de_f(i-1);
        de_b(i) = -u(i-nk)-theta0(1)*de_b(i-1);
    end

    suma_H=[0 0 ;0 0];
    suma_de_v = [0 0];
    for i = 1:N
        suma_de_v = suma_de_v +e(i)*[de_f(i) de_b(i)];
 
    end
 
    for i = 1:N
        suma_H = suma_H + [de_f(i);de_b(i)]*[de_f(i);de_b(i)]';
     end
    H=2/(N-nk)*suma_H;
    de_v=2/(N-nk)*suma_de_v';
 
    theta = theta0;
    theta0 = theta-alpha*inv(H)*de_v;
    L_minim = L_minim + 1;
    if(norm ( theta0-theta ) <=ts) 
        break
    end
end

val=iddata (yval',uval,0.01);
modelOE = idpoly(1,[zeros(1,nk) theta0(2)],1,1,[1 theta0(1)], 0, 0.01);
compare(modelOE,val);