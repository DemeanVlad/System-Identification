load('scotdate.mat')

%plot(u)
%plot(vel)

yid1 = y(1:211); yval = y(211:end);
uid1 = u(1:211); uval = u(211:end);
Ts = 0.01;
N = 211;
k = 1;
na = 30;
nb = 30;


date_indentificare = iddata(yid1, uid1, Ts);

identificare_date = date_indentificare.u;
arx_model = arx(identificare_date, [na nb 1]);
y_hat = lsim(arx_mode, uid1);

for i = 1:N
    for j = 1:na
        if(i-j)<=0
        A(i,j) = 0;
        else
        A(i,j) = -y_iesire(i-j);
    end
    end

    for j = 1:nb
       if(i-j)<=0
        A(i, na+j) = 0;
       else
        A(i, na+j) = x1(i-j);
       end
    end
    end