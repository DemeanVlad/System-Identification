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

N = length(y01);
Ru = ones(1,N);
Ry = ones(1,N);

for Tau = 1:N
for i = 1 : N-Tau
    sumRu = 0;
    sumRu = x01(i+Tau)-x01(i);
    
end
Ru(i,j) = 1/N*sum(sumRu);
    for j = 1 : N-Tau
      sumRy = 0;
        sumRy = y01(j+Tau)-x01(j);
        
    end
    Ry(j,Tau) = 1/N*sum(sumRy);
end


%Ru_matrice = [Ru, 1/N*sum(sumRu)];
%Ry_matrice = [Ry; 1/N*sum(sumRy)];

%facem matricea
%calculam h
%conv
%mse
%plot
%M reglabil din for
c= 40;

Matricea = zeros(m,n);

%m = 1:N;
for a = 1:n
    for m= 1:c %N lungimea iesiri
            Matricea(a, m) = Ru(abs(a - m)+1);
    end
    end
    H = Matricea\Ry';


    yaprox=conv(H,x2);
    figure;
    plot(yaprox)
    hold on
    plot(y2)