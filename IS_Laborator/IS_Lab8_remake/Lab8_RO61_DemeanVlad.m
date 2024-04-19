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
 
%id_data = iddata(yid1', uid1, ts);
%val_data = iddata(yval', uval, ts);
 
%u_id = id_data.u;
%y_id = val_data.y;
 
%N = 80;
N = length(yid1);
%plot(u_id);
%figure
%plot(y_id)
b = 1;
f = 1;
theta0 = [b,f];
de_f = zeros(1,N);
de_b = zeros(1,N);
while(L_minim<N)
 
    e(1:nk)=vel(1:nk);
    for i = nk+1:N
        e(i) = vel(i) + theta0(1)*vel(i-1)- theta0(2)*u(i-nk)-theta0(1)*e(i-1);
        de_f(i) =vel(i-1)-e(i-1)-theta0(1)*de_f(i-1);
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
    if(norm ( theta0-theta ) <=0.01) break
    end
end
val=iddata (yval',uval,0.01);
modelOE = idpoly(1,[zeros(1,nk) theta0(2)],1,1,[1 theta0(1)], 0, 0.01);
compare(modelOE,val);