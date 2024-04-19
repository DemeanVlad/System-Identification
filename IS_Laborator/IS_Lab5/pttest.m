load('lab5_8.mat')

x1 = id.u; 
x2 = val.u;
y1 = id.y; 
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

M = length(x01); %lungimea intrarii
N = length(y01); %lungimea iesirii

Ru = ones(1,N);
Ry = ones(1,N);

for Tau = 1:N
    SumRy = 0;
    SumRu = 0;
    for i = 1: N-Tau
        SumRy = SumRy + y01(i+Tau-1)*x01(i);
    end
Ry(Tau) = 1/N*(sum(SumRy));
    for j = 1:N-Tau
        SumRu = SumRu + x01(j+Tau-1)*x01(j);
    end
Ru(Tau) = 1/N*(sum(SumRu));
end
m = 60;
a = 0;
b = 0;
%Matricea = zeros(a, b);
for a = 1:N
    for b = 1:m
        Matricea(a,b) = Ru(abs(a - b)+1);
    end
end

H = Matricea\Ry';
yaprox=conv(H,x2);
    figure;
    plot(yaprox)
    hold on
    plot(y2)
    hold on

    plot(H)