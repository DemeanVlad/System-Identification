clear all;
clc;
close all;

load('data.mat');

y_id1 = speed(1:183);
y_id2 = speed(184:235);
yval = speed(236:end);

u_id1 = u(1:183);
u_id2 = u(184:235);
uval = u(236:end);

%plot(t, speed);
%figure;
%plot(u);

%hold on;
%plot(y_val2);

N = length(u_id2);
theta_dV = [1, 1];
l = 0;
l_max =150;
nk = 2;
delta = 10e-6;
alpha = 0.1;
ts = 0.01;


while (l < l_max)
e_k = zeros(1, length(N));
df_k = zeros(1, length(N));
db_k = zeros(1, length(N));
b = theta_dV(2);
f = theta_dV(1);
for k = 1:N  
    e_k(k) = speed(k);
end

for k = nk + 1:length(N)
    e_k(k) = u_id1(k) + u_id1(k - 1)*f -b*u_id1(I-nk)+ f *e_k(k-1);
    df_k = u_id1(k-1)-e_k(k-1)- f*df_k(k-1);
    db_k = -u_id1(k-nk)-f*db_k(k-1);
end

  theta_v = theta_dV;

    H = zeros(2, 2);
    dV = zeros(2, 1);
    de_k = [df_k,db_k];
    
    for k = 1:length(N)
    %dV(1, 1) = dV(1, 1) + sum(e_k);
    %dV(2, 1) = dV(2, 1) + sum(e_k .* u);
    dV = dV + e_k(k)*de_k(:,k);
    end

    theta_dV = theta_dV - alpha * inv(H) * dV;

    for k = 1:length(N)
        H = H + e_k(k) * e_k(k)';
    end
    H = 2/(N-nk)*H;
    theta_n=theta_dV+ alpha*(inv(H))*dV;
    
    theta_dV = theta_dV - alpha * inv(H) * dV;
    l = l + 1;

    if (norm(theta_n - theta_dV) <= delta)
        break
    end
end

A = 1;
B = [0, theta_dV(1)];
C = 1;
D = 1;
F = [1, theta_dV(2)];
ts = 0.01;

figure;
model = idpoly(A, B, C, D, F, 0, ts);
val = iddata(yval', uval,ts);
compare(model, val);