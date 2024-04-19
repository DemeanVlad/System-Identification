clc;clear all;close all;
load('datemotor.mat')


yid = vel(1:210); yval = vel(210:end);
uid = u(1:210); uval = u(210:end);


Ts = 0.01;

%id_data = iddata(yid', uid,ts);
%val_data = iddata(yval',uval,ts);

id_date = iddata(yid', uid, Ts);
val_date = iddata(yval', uval, Ts);

u_id = id_date.u;
y_id = id_date.y;

N = length(uid);
na = 2;
nb = 2;

arx_model = arx(id_date,[na nb 1]);
y_hat = lsim(arx_model,uid);

A = zeros(N, na+nb);
for i = 1:N
    for j = 1:na
        if(i-j)<=0
        A(i, j) = 0;
        else
        A(i, j) = -y_id(i-j);
        end
    end
     for j = 1:nb
         if(i-j)<=0
             A(i, j+na) = 0;
         else
             A(i, j+na) = u_id(i-j);
         end
     end
end

 v = zeros(N, na+nb);
 for i = 1:N
     for j = 1:na
            if(i-j)<=0
                v(i,j) = 0;
            else
                v(i, j) = -y_hat(i-j);
            end
     end
     
 for j = 1:nb
    if(i-j)<=0
            v(i, j+na) = 0;
        else
           v(i, j+na) = u_id(i-j);
        end
    end
 end
    
sum1 = 0;
for i = 1:N
    sum1 = sum1 + v(i,:)'*A(i,:);
end

A2 = (1/N)*sum1;

    sum2 = 0;
for i = 1:N
    sum2 = sum2 + v(i,:)*y_id(i);
end
A3=(1/N)*sum2;
    
teta = A2\A3';

A = [1, teta(1:na)'];
B = [0, teta(na+1:end)'];
C = 1;
D = 1;
F = 1;

model_varinst = idpoly(A,B,C,D,F,0,Ts);
compare(model_varinst, val_date)







