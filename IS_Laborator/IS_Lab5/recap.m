load("lab5_8.mat")
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

M = length(x01);
N = length(y01);
Ry = ones(1, N);
Ru = ones(1,N);


for Tau = 1:N
    sumRy = 0;
    sumRu = 0;
    for i = 1:N - Tau
        sumRy = sumRy + y01(i+Tau-1)*x01(i);
    end
    Ry(Tau) = 1/N*sum(sumRy);
    
    for j = 1: N - Tau
        sumRu = sumRu +x01(j+Tau-1)*x01(j);
    end
    Ru(Tau) = 1/N*sum(sumRu);
end
m = 60;
a = 0;
b = 0;

Matricea = zeros(a,b);

for i = 1:N
    for j = 1:m
Matricea(a, b) = Ru(abs(a - b) + 1);
    end
end
H = Matricea\Ry';
yaprox = conv(H, x2);
plot(yaprox)
hold on
plot(y2)
figure
hold on
plot(H)


