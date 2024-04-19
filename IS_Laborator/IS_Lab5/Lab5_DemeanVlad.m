%setul de date 8
load('lab5_8.mat')

x1 = id.u;
y1 = id.y;

x2 = val.u;
y2 = val.y;

plot(x1)
figure
hold on
plot(y1)

x01 = detrend(x1);
y01 = detrend(y1);

plot(x01)
figure
hold on
plot(y01)

M =length(x01);
N = length(y01);
%Tau = N-1;
Ru = ones(1,N);
Ry = ones(1,N);
  

for Tau = 1 : N
  sumRy = 0;
  sumRu = 0;
    for j = 1 : N-Tau
        sumRy = sumRy + y01(j+Tau-1)*x01(j);
     
    end
       Ry(Tau) = 1/N*(sum(sumRy));
    for i = 1 : N-Tau
    sumRu = sumRu + x01(i+Tau-1)*x01(i);
   
    end
    Ru(Tau) = 1/N*(sum(sumRu));  
end

%Ru_matrice = [Ru, 1/N*sum(sumRu)];
%Ry_matrice = [Ry; 1/N*sum(sumRy)];

%facem matricea
%calculam h
%conv
%mse
%plot
%M reglabil din for
m = 60;
a =0;
b=0;

Matricea = zeros(a,b);

for a = 1:N
    for b = 1:m %N lungimea iesiri
            Matricea(a, b) = Ru(abs(a - b) + 1);
    end
end


    H = Matricea\Ry';

    yaprox=conv(H,x2);
    figure;
    plot(yaprox)
    hold on
    plot(y2)
    hold on
    figure;
    plot(H)