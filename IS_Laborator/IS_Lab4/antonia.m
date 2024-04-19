load('lab4_order1_4') 
x1= data.InputData; 
y1 = data.OutputData; 


plot(t,x1); 
figure 
hold on
plot(t,y1)

yss1= 1.46; %de unde pleaca graficul
uss= 1.5; %linia de stabilizare
ymax= 3.42; %varful
y1=yss1+(ymax-yss1)*0.368; 

k=yss1/uss;
t1= 0.92; %primul de jos, inainte sa urce
t2= 1.8; %x de la y1
%T=t2-t1; 
T=0.5;
A1=-1/T; 
B1=k/T; 
C1=1;
D1=0; 
H1=ss(A1,B1,C1,D1); 
yaprox1=lsim(H1, x1,t,yss1);
plot(t,y1,t,yaprox1)


%%

load('lab4_order2_4.mat')
x2= data.InputData;
y2= data.OutputData; 


plot(x2)
hold on
figure
plot(t,y2)



yss2= 0.24;
uss= 1;
y0=yss2; %e val de la inceput
K=yss2/uss;
t3=t(39); %x ul de la primul varf
t4=t(81); %x ul de la al doilea varf
T1=t4-t3;
k0=31; %de acolo de unde porneste oscilatia
k1=55; %pe partea cealalta de grafic, 
% y de la k0 si k1 sa coincida cat de cat
k2=78; %x de la a doua oscilatie
Ts=t(20)-t(19);
A1=0;
A3=0;
for k=k0:k1 
    A1=A1+sum(y2(k)-y0);
    
end 
for k=k1:k2 
    A3=A3+sum(yss2-y2(k));
end 

Aplus=Ts*A1;
Aminus=Ts*A3;

M=Aminus/Aplus; 
tita=(-log(M))/(sqrt(pi^2+(log(M))^2));
wn=(2*pi)/(T1*sqrt(1-tita^2));
A2=[0 1 ; -wn^2  (-2)*tita*wn]; 
B2=[0 ; K*wn^2]; 
C2=[1 0]; 
D2=0; 


H2=ss(A2,B2,C2,D2); 
yaprox2=lsim(H2,x2,t, [yss2 0]); 
figure
plot(t,y2)
hold on 
plot(t,yaprox2)

N=length(y2); 
P=y2-yaprox2;
s=0; 
for i=1:N
    s=s+P(i).^2;
end 

MSE=(1/N)*(sum(s));