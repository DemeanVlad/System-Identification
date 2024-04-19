
u_z = zeros(10,1);
N = 3;
u_spab = idinput(N, 'prbs', [], [-0.7 0.7]);
u_step0.4*ones(70,1);
u = [u_z; u_spab; u_step];
[vel,alpha,t] = run(u, 'serialport');
%scrii seriallist sa vezi cum se numeste portu
plot(t,vel)

b = -0.7;
c = 0.7;
M0maxim = 10;
M_minim = 3;
Ts = 0.01;

%sau poti face pe validare, e mai ok pe validare cica da puteti sa l
%intrebati pe elvin
id1 = iddata(vel',u,Ts);
id2 = iddata(vel', u, Ts);

na = 2;
nb = 2;
nk = 4;

Model1 = arx(id1, [na,nb,nk]);
Model2 = arx(id2, [na,nb,nk]);

compare(Model1, id1)
figure;hold on;
compare(Model2, id2)