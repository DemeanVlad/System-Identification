clc;clear all;close all;
load('dataset2.mat')

N = 200;
M_maxim = 10;
M_minim = 7;
b = -0.7;
c = 0.7;

U = [zeros(1,10), SPAB(N, M_minim, b,c), zeros(1, 10), SPAB(N, M_maxim, b,c), zeros(1, 10), 0.4*ones(1, 70)];
plot(U)
nk = 2;
na = 4;
nb = 4;

Model1 = arx(id1, [nk,na,nb]);
Model2 = arx(id2, [nk,na,nb]);

figure
compare(Model1, val,200);
figure
compare(Model2, val,200);
function [sp] = SPAB(N, M_minim, b, c)
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
if M_minim == 3
    a(3) = 1;
    a(10) = 1;
end


x = ones(1,M_minim);
x2 = zeros(1,M_minim);

for i = 1:N
    x2(1) = mod(sum(a.*x),2);
    x2(2:end) = x(1:end-1);
    sp(i) = x2(1);
    x2 = x;
end

sp = b+(c-b)*sp;
end





