clear all
close all
clc

load('iddata-01.mat')

uid = id.u;
yid = id.y;

uval = val.u;
yval = val.y;

%subplot(2, 1, 1)
%plot(uid)
%subplot(2, 1, 2)
%plot(yid)
%figure
%subplot(2, 1, 1)
%plot(uval)
%subplot(2, 1, 2)
%plot(yval)
%figure

na = 1;
nb = 2;
nk = 1;
m = 3;

pc = puteri_coeficienti(na, nb, m);

%predictie identificare

x_id = zeros;

for  k = 1 : length(uid)
    for i = 1 : na
        if k - i <= 0
            x_id(k, i) = 0;
        else
            x_id(k, i) = -yid(k - i);
        end
    end

    for j = 1 : nb
        if k - j <= 0
            x_id(k, na + j) = 0;
        else
            x_id(k, na + j) = uid(k - j);
        end
    end
end

phi_id = zeros;
k = 1;
for i = 1 : length(uid)
    for p = 1 : length(pc)
        phi_id(k, p) = 1;
        for j = 1 : na + nb
            phi_id(k, p) = phi_id(k, p) * (x_id(i, j) ^ pc(p, j));
        end  
    end   
    k = k + 1;
end

theta = phi_id \ yid;

yid_pred = phi_id * theta;

s = 0;
for i = 1 : length(yid)
    s = s + (yid(i) - yid_pred(i))^2;
end
MSEid_pred = 1/length(yid) * s;

plot(yid, 'b')
hold on
plot(yid_pred, 'r')
legend('iesire identificare', 'predictie')
title('Predictie identificare')
    
%simulare identificare

xs_id = zeros;
yid_sim = zeros(length(uid), 1);
phis_id = zeros;

for  k = 1 : length(uid)
    for i = 1 : na
        if k - i <= 0
            xs_id(k, i) = 0;
        else
            xs_id(k, i) = -yid_sim(k - i);
        end
    end

    for j = 1 : nb
        if k - j <= 0
            xs_id(k, na + j) = 0;
        else
            xs_id(k, na + j) = uid(k - j);
        end
    end

    for p = 1 : length(pc)
        phis_id(k, p) = 1;
        for j = 1 : na + nb
            phis_id(k, p) = phis_id(k, p) * (xs_id(k, j) ^ pc(p, j));
        end  
    end
    yid_sim(k) = phis_id(k,:) * theta;
end

s = 0;
for i = 1 : length(yid)
    s = s + (yid(i) - yid_sim(i))^2;
end
MSEid_sim = 1/length(yid) * s;

figure
plot(yid, 'b')
hold on
plot(yid_sim, 'r')
legend('iesire identificare','simulare')
title('Simulare identificare')

%predictie validare

x_val = zeros;

for  k = 1 : length(uval)
    for i = 1 : na
        if k - i <= 0
            x_val(k, i) = 0;
        else
            x_val(k, i) = -yval(k - i);
        end
    end

    for j = 1 : nb
        if k - j <= 0
            x_val(k, na + j) = 0;
        else
            x_val(k, na + j) = uval(k - j);
        end
    end
end

phi_val = zeros;
k = 1;
for i = 1 : length(uval)
    for p = 1 : length(pc)
        phi_val(k, p) = 1;
        for j = 1 : na + nb
            phi_val(k, p) = phi_val(k, p) * (x_val(i, j) ^ pc(p, j));
        end  
    end   
    k = k + 1;
end

yval_pred = phi_val * theta;

s = 0;
for i = 1 : length(yval)
    s = s + (yval(i) - yval_pred(i))^2;
end
MSEval_pred = 1/length(yval) * s;

figure
plot(yval, 'b')
hold on
plot(yval_pred, 'r')
legend('iesire identificare', 'predictie')
title('Predictie validare')
    
%simulare validare

xs_val = zeros;
yval_sim = zeros(length(uval), 1);
phis_val = zeros;

for  k = 1 : length(uval)
    for i = 1 : na
        if k - i <= 0
            xs_val(k, i) = 0;
        else
            xs_val(k, i) = -yval_sim(k - i);
        end
    end

    for j = 1 : nb
        if k - j <= 0
            xs_val(k, na + j) = 0;
        else
            xs_val(k, na + j) = uval(k - j);
        end
    end

    for p = 1 : length(pc)
        phis_val(k, p) = 1;
        for j = 1 : na + nb
            phis_val(k, p) = phis_val(k, p) * (xs_val(k, j) ^ pc(p, j));
        end  
    end
    yval_sim(k) = phis_val(k,:) * theta;
end

s = 0;
for i = 1 : length(yval)
    s = s + (yval(i) - yval_sim(i))^2;
end
MSEval_sim = 1/length(yval) * s;

figure
plot(yval, 'b')
hold on
plot(yval_sim, 'r')
legend('iesire identificare','simulare')
title('Simulare validare')

function pc = puteri_coeficienti(na, nb, m)
    pc = zeros;
    
    for i = 1 : m + 1
        pc(i) = i - 1;
    end
    
    pc = unique(nchoosek(repmat(pc, 1, na + nb), na + nb),'rows');
    
    k = 1;
    while(k <= length(pc))
        if(sum(pc(k,:)) > m)
            pc(k,:) = [];
            k = k - 1;
        end
        k = k + 1;
    end
end