%% generare semnal
clear all;
uz=zeros(60,1);
uz=uz(:);
N1=70;
T=0.01;
ustep=0.3*ones(N1,1);
u_val=[uz;ustep;uz];
N2=200;
uspab=idinput(N2,'prbs',[],[-0.8,0.8]);
uid=[uz;uspab];
motor=DCMRun.start();
leng_uval=length(u_val);
leng_uid=length(uid);
for i=1:leng_uval
yval(i)=motor.step(u_val(i));
end


delta=1000;
na=1;
nb=2;
Nbun=na+nb;
teta_hat=zeros(Nbun,1);
P=delta*eye(Nbun);
A=zeros(Nbun,Nbun);

yid=zeros(length(uid), 1);


for k=1:leng_uid
yid(k)=motor.step(uid(k));
 % ARX recursiv
 Fi=[];
for i=1:na
        if(k>i)
            Fi(i)= -yid(k-i);
        else
            Fi(i)=0;
        end
    end 
    for j=1:nb
        if(k>j)
            Fi(na+j)=uid(k-j);
        else
            Fi(na+j)=0;
   end
end
Fi=Fi';
err(k)=yid(k)-Fi'*teta_hat;
P=P-(P*Fi*Fi'*P)/(1+Fi'*P*Fi);
w=P*Fi;
teta_hat= teta_hat+w*err(k)

if(k==13)
    teta_procent=teta_hat;
end

 motor.wait();
end
motor.stop();

A=[1,teta_hat(1:na)];
B=[1,teta_hat(na+1:end)'];
A_procent=[1,teta_procent(1:na)];
B_procent=[1,teta_procent(na+1:end)'];



model_recursiv=idpoly(A,B,[],[],[],0,0.01);
model_recursiv_procent=idpoly(A_procent,B_procent,[],[],[],0,0.01);
validare=iddata(yval',u_val,0.01);
figure; compare(model_recursiv,validare);
figure; compare(model_recursiv_procent,validare);