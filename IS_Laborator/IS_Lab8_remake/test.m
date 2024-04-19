load('datemotor.mat')

figure; 
plot(u);
title('Semnal u')
figure;
plot(vel);
title('Semnal vel')
u1=u(1:212);
y1=vel(1:212);
u2=u(212:end);
y2=vel(212:end);


nk=2;
Ts=0.01;
alfa=0.2; 
delta=10e-5;
theta0=[1;1];
N=200;
id_model=iddata(y1',u1, Ts);
val_model=iddata(y2',u2, Ts);
uid=id_model.u;
yid=id_model.y;

l=0; %counterul de iteratii
%lmax=N

b=1;
f=1;
teta=[b;f];
e=zeros(1,N);
e(1)=0;

while l<N
for k=1:N
    e(k)= yid(k);
    deriv_f=zeros(1,N);
    deriv_b=zeros(1,N);
end

for k=nk+1:N
    e(k) = yid(k) + (yid(k-1)-e(k-1))*f- uid(k-nk)*b;
           deriv_f(k) = -deriv_f(k-1)*f + yid(k-1) - e(k-1);
            deriv_b(k) = -deriv_b(k-1)*f- uid(k-nk);

end

    H = zeros(2, 2); %hessian
    dV = zeros(2, 1); %gradient
    for k = 1:N
        dV = dV + (2/N) * (e(k)* [deriv_f(k); deriv_b(k)]);
         H = H + (2/N) * ([deriv_f(k); deriv_b(k)] * [deriv_f(k) deriv_b(k)]);
    end

teta1=teta;
teta=teta1-alfa*inv(H)*dV;
l=l+1;

end

A=1;
B = [0, b];
C=1;
D=1;
F=[1, f];


model=idpoly(A,B,C,D,F,0,Ts);
figure
compare(model,val_model)

