clear all;
clc;
u_val = [zeros(50,1); 0.3*ones(70,1); zeros(50,1)];
u_id=spab(10,200,-0.8,0.8);

motor= DCMRun.start("port", "COM5", "Ts", 10e-3);



for k = 1:length(u_val)
    y_val(k)= motor.step(u_val(k));
end


plot(y_val);

%Partea 3

na=2;
nb=2;
theta=zeros(na+nb,1);
theta_caciulita=theta;
p_minus1=zeros(na+nb,na+nb);
coeficient=1000;
p_minus1=coeficient*eye(na+nb);
Nid=length(u_id);
Nval=length(u_val);


for k=1:Nval
    y_val(k)=motor.step(u_val(k));
end
phi =zeros(na+nb,1);
for i=2:Nid
    y_id(i)=motor.step(u_id(i));
    for k=1:1:na
        if i>k
            phi(k)= -y_id(i-k);
        else
            phi(k)= 0;
        end
    end
    for l=1:1:nb
        if i>l
            phi(l+na)=u_id(i-l);
        else
            phi(l+na)=0;
        end
    end
    Eroare_predictie=y_id(i)-phi'*theta_caciulita(:,i-1);
    p_minus1=p_minus1-(p_minus1*phi*phi'*p_minus1)/(1+phi'*p_minus1*phi)
    w=p_minus1*phi;
    theta_caciulita(:,i)=theta_caciulita(:,i-1)+w*Eroare_predictie;
    motor.wait();
end

motor.stop();

A=theta_caciulita(1:na,end)';
B=theta_caciulita(na+1:end,end)';
val=iddata(y_val',u_val,0.01);
model=idpoly([1 A],[0 B],[],[],[],0,0.01);
compare(model,val)



function u=spab(m,N,a,b)
u = ones(1,N);
val_x_m=zeros(1,m);
val_x_m(1)=1;
coeficient=zeros(m,1);
coeficient(m)=1;

if m==3 
    coeficient(1)=1;
elseif m==4
    coeficient(1)=1
elseif m==5
    coeficient(2)=1;
elseif m==6
    coeficient(1)=1;
elseif m==7
    coeficient(1)=1;
elseif m==8
    coeficient(1)=1;coeficient(2)=1;coeficient(7)=1;
elseif m==9
    coeficient(4)=1;
elseif m==10
    coeficient(3)=1;
end
for j=1:N
    u(j) = val_x_m(m);
    calculare = mod(val_x_m*coeficient, 2);
    val_x_m = circshift(val_x_m, 1);
    val_x_m(1) = calculare;
end
u = a+(b-a)*u;
end