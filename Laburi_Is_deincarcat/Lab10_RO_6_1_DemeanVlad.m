%%lab10
clear all;close all;

N = 10;
M_minim = 200;
b = -0.7;
c = 0.7;
u_impuls = [zeros(40,1); 0.3*ones(70,1); zeros(50,1)];
u = SPAB(N,M_minim,b,c);

serial_moto = DCMRun.start("port", "COM5", "Ts", 10e-3);

y = zeros(1,N);

for k = 1:length(u)
    serial_moto.wait;
    y(k) = serial_moto.step(u(k));
end

serial_moto.stop();

plot(y);

ts = 0.01;
na = 3;
nb = 3;
y_hat = zeros(1, na+nb)';
p_invers = zeros(na+nb,na+nb);
delta = 1000;
p_invers_1 = delta*eye(na+nb);

N_identificare = length(u_impuls);
N_validare = length(u);

for i = 1:N_validare
    y(i) = serial_moto.step(u_impuls);
end

PHI_arx = zeros(1, na+nb)';
    for m = 1:N_identificare
        y1(m) = serial_moto.step(u_id(m));
        for n = 1:na
            if(m-n)<=0
        PHI_arx(m,n) = 0;
            else
        PHI_arx(m,n) = -y1(m-n);
            end
    end

for j = 1:nb
    if(m-j)<=0
        PHI_arx(m, na+j) = 0;
    else
        PHI_arx(m, na+j) = u(m-j);
        %daca nu merge sa l fac vector
    end
end

   phi_arx = [1, PHI_arx];
%trans daca nu merge

   e(i) = y1(k)-THETA*(phi_arx'); 
   p_invers1 = p_invers1-(p_invers1*phi_arx*(phi_arx')*p)... 
       /(1+(phi_arx')*p*phi_arx);
   %daca nu merge sa l fac simplu
   w = p*phi_arx;
   THETA = THETA+w*e(i);
   serial_motor.wait();
end

serial_motor.stop();

model_val = iddata(y',uimpuls,ts);
A = [1; y_hat(1:na,nb)]';
B = [1;y_hat(na+1:end, end)]';

model_arx_online = idpoly([1 A], [0, B], [], [], [],0,0.01);
compare(model_arx_online, model_val)

function [sp] = SPAB(N, M_minim,b,c)
a = zeros(1,M_minim);
if M_minim == 3
    a(1) = 1;
    a(3) = 1;
end
if M_minim == 4
    a(1) = 1;
    a(4) = 1;
end
if M_minim == 5
    a(2) = 1;
    a(5) = 1;
end
if M_minim == 6
    a(1) = 1;
    a(6) = 1;
end
if M_minim == 7
    a(1) = 1;
    a(7) = 1;
end
if M_minim == 8
    a(1) = 1;
    a(2) = 1;
    a(7) = 1;
    a(8) = 1;
end
if M_minim == 9
    a(4) = 1;
    a(9) = 1;
end
if M_minim == 10
    a(3) = 1;
    a(10) = 1;
end

x = ones(1,M_minim);
x2 = zeros(1,M_minim);

for j = 1 : N
   x2(1) = mod(sum(a.*x),2);
   x2(2:end) = x(1:end-1);
   sp(j) = x2(1);
   x = x2;
    end
    
    sp = b+(c-b)*sp;

end

