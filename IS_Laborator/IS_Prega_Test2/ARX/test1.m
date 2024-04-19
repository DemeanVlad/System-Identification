clear all;close all; clc;
load('lab6_1.mat')

x1 = id.u;
y1 = id.y;

%plot(x1)
%figure
%plot(y1)

N = length(x1);
A = [];
nk = 1;
nb = 15;
na = 15;

for i = 1:N
    for j = 1:na
        if(i-j)<=0
            A(i, j) = 0;
        else
            A(i,j) = -y1(i-j);
        end
    end

    for m = 1:nb
        if(i-j)<0
            A(i, m+na) = 0;
        else
            A(i, m+na) = -y1(i-j+na);
        end
    end
end

teta = A\y1;
y_hat = A*teta;

%figure
%plot(y_hat)
%hold on;
%plot(y1)

x_simulare = val.u;
y_simulare = val.y;


%plot(x_simulare)
%hold on
%figure
%plot(y_simulare)

A_simualre(1,:) = [zeros(1,na) x_simulare(1) zeros(1,nb-1)];
na = 18;
nb =18;

lungime = length(x_simulare);
y_hat_aproximativ = zeros(lungime, 1);

for i = 1:lungime
    for j = 1:na
        if(i-j)<=0
            A_sim(i,j) = 0;
        else
            A_sim(i,j) = -y_hat_aproximativ(i-j+1);
        end
    end

    for m = na+1:na+nb
        if(i-m+na)<= 0
            A_sim(i, m) = 0;
        else
            A_sim(i, m) = x_simulare(i-m+na+1);
        end
   end
    y_hat_aproximativ(i+1) = A_sim(i,:).*teta';
end

figure
plot(y_hat_aproximativ)
hold on;
plot(y_simulare)




















