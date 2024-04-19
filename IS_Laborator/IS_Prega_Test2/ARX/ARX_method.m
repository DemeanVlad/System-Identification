clc;clear all;close all;
load("lab6_1.mat")

x1 = id.u;
y1 = id.y;

%plot(x1)
%figure
%hold on
%plot(y1)

A = [];
m = length(x1);
na = 18;
nb = 18;

for i = 1:m
    for j = 1:na
        if (i-j)<=0
            A(i,j) = 0;
        else
            A(i,j) = -y1(i-j);
        end
    end

    for u = 1:nb
        if (i-u)<=0
            A(i,u+na) = 0;
        else
            A(i,u+na) = x1(i-u);
        end
    end
end

teta = A\y1;
y_hat = A*teta;

figure
plot(y_hat)
hold on
plot(y1)


%predictie
 
x_simulare = val.u;
y_simulare = val.y;



%A_simulare = [];
A_simualre(1,:) = [zeros(1,na) x_simulare(1) zeros(1,nb-1)];

lungime = length(y_simulare);
y_aprox_lungime = zeros(lungime, 1);

for i = 1:lungime
    for j = 1:na
        if (i-j)<=0
            A_simulare(i, j) = 0;
        else
            A_simulare(i, j) = -y_aprox_lungime(i-j+1);
        end
    end

    for m = na+1:na+nb
        if(i-m+na)<=0
            A_simulare(i, m) = 0;
        else
            A_simulare(i, m) = x_simulare(i-m+na+1);
        end
    end
    y_aprox_lungime(i+1) = A_simulare(i,:)*teta;
end

figure
plot(y_aprox_lungime)
hold on
plot(y_simulare)










