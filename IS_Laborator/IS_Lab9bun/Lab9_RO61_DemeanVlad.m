clear all;clc
%load('Cristinelu.mat')
load('datemotor.mat')
%load('Paula_lab9.mat')
%plot(u)
%plot(vel)

yid1 = vel(1:210); yval = vel(210:end);
uid1 = u(1:210); uval = u(210:end);

%yid1 = y(8:301); yval = y(8:301);
%uid1 = u(8:301); uval = u(301:end);

Ts = 0.01;
N = length(uid1);
k = 1;
na = 4;
nb = 4;
A = [];

identificare_data = iddata(yid1', uid1, Ts);
validare_data = iddata(yval', uval,Ts);

u_id = identificare_data.u;
y_id = identificare_data.y;

arx_model = arx(identificare_data, [na nb 1]);
y_hat = lsim(arx_model, uid1);

y_iesire = zeros(length(N),1);
phi = zeros(N, na+nb);
for i = 1:length(u_id)
    for j = 1:na
        if(i-j)<=0
        phi(i,j) = 0;
        else
        phi(i,j) = -y_id(i-j);
    end
    end

for j = 1:nb
    if(i-j)<=0
        phi(i, na+j) = 0;
    else
        phi(i, na+j) = u_id(i-j);

    end
end
end

y_aprox = zeros(length(u_id),1);
v = zeros(N, na+nb);


for i = 1:length(u_id)
    for j = 1:na
        if(i-j)<=0
        v(i,j) = 0;
        else
        v(i, j) = -y_hat(i-j);
    end
    end

    for j = 1:nb
    if(i-j)<=0
        v(i, na+j) = 0;
    else
        v(i, na+j) = u_id(i-j);
    end
 end
end

suma = 0;
for i = 1:N
    suma = suma + (v(i, :)'*phi(i,:));
        end
        
    A2 = (1/N)*suma; %phi


suma2 = 0;
  %  for j = 1:na+nb
for i = 1:N
    suma2 = suma2 + (v(i,:)*y_id(i));
        end

    A3 = (1/N)*suma2;%y
    
Theta = A2\A3';
A_teta= [1, Theta(1:na)'];
B = [0, Theta(na+1:end)'];
C = 1;
D = 1;
F = 1;

model_var_instrumentabile = idpoly(A_teta,B,C,D,F,0,Ts);

%yaprox2= lsim(model_var_instrumentabile, uval);
compare(model_var_instrumentabile, validare_data)

