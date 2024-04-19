%%LABORATORUL2
load('lab2_08');
id.X;
id.Y;
%plot(id.X, id.Y);figure;
%plot(val.X, val.Y);


for c = 1:25
a = length(val.Y);
A = zeros(a,c);


for i = 1:1:a
    for j = 1:1:c
   A(i,j) = (val.X(i))^(j-1);

    end
end

for i = 1:1:length(id.X)
    for j = 1:1:c
   teta(i,j) = (id.X(i))^(j-1);

    end
end

B = teta\id.Y';
y_val = A*B;
disp(B);

%MSE
val_s = 0;
for j = 1:1:length(val.X)
   val_s = val_s + ((val.Y(j))'-y_val(j)).^2;
end
   
MSE = ((1/a)*sum(val_s));
val_MSE(i) = MSE;
end

plot(val.X ,val.Y, val.X, y_val) 
figure;
plot(1:length(val_MSE), val_MSE)



