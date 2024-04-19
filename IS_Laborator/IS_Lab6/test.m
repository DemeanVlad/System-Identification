close all;clc;clear all;

load('lab6_8.mat');

xid=id.U; yid=id.Y;
% 
% subplot(211)
% plot(yid);
% subplot(212)
% plot(xid);
nk=1; 
na=15;
nb=15;

% model=arx(id, [na nb nk]); compare(model, val);

PHI=[];
s=length(xid);
for m=1:s
    for i=1:na
        if (m-i)<=0
            PHI(m,i)=0;
        else
            PHI(m,i)= -yid(m-i);
        end
    end

    for j=1:nb
        if (m-j)<=0
            PHI(m,na+j)=0;
        else
            PHI(m,na+j)=xid(m-j);
        end
    end
end
THETA=PHI\yid;
yapx=PHI*THETA;

figure
plot(yapx)
hold on
plot(yid)
MSE=mean((yid-yapx).^2);

%%val
xval=val.U; yval=val.Y;
% figure
% subplot(211)
% plot(yval);
% subplot(212)
% plot(xval);

PHI2=[];

r=length(xval);

PHI(1,:)=[zeros(1,na) xval(1) zeros(1,nb-1)]
yest=zeros(r,1);
yest(1)=PHI(1,:)*THETA;


for m=2:r
    for i=1:na
        if m-i<=0
            PHI2(m,i)=0;
        else   
            PHI2(m,i)=-yest(m-i+1);  
        end
    end


    for j=na+1:nb+na
        if m-j+na<=0
            PHI2(m,j)=0;
        else   
            PHI2(m,j)=xval(m-j+na+1);
        end
    end
    yest(m+1)=PHI2(m,:)*THETA;
end

%y_val_apx=PHI2*THETA;

figure
plot(yest)
hold on
plot(yval)
%MSE2=mean((yval - y_val_apx).^2);
