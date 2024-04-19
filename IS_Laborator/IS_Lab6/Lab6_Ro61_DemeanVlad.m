clear all; close all;
load('lab6_2.mat');

x1 = id.u;
y1 = id.y;

%plot(x1)
%figure
%hold on
%plot(y1)

%construim matricea phi care e A aici

A = [];
m = length(x1);
k = 1;
na = 15;
nb = 15;

for i = 1:m
    for j = 1:na
        if(i-j)<=0
        A(i,j) = 0;
        else
        A(i,j) = -y1(i-j);
    end
    end

for j = 1:nb
    if(i-j)<=0
        A(i, na+j) = 0;
    else
        A(i, na+j) = x1(i-j);

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

%plot(x_predictie)
%figure
%hold on
%plot(y_predictie)

A_simulare = [];
lungime_simulare_intrare = length(y_simulare);

%A_simulare(1,:) =[zeros(1,na) x_simulare(1) zeros(1, nb-1)];

y_aprox_simulare = zeros(lungime_simulare_intrare,1);


%constr matrice

for m = 1:lungime_simulare_intrare
    for n = 1:na
        if m-n<0
            A_simulare(m,n) = 0;
        else 
            A_simulare(m,n) = -y_aprox_simulare(m-n+1);
        end
    end

for u = na+1:nb+na
    if m-u+na<=0
        A_simulare(m,u) = 0;
    else
        A_simulare(m,u) = x_simulare(m-u+na+1);
    end
end
y_aprox_simulare(m+1)= A_simulare(m,:)*teta;
%y_hat2 = A_predictie*teta;
end


figure
plot(y_aprox_simulare)
hold on
plot(y_simulare)


