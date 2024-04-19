U = [zeros(1,10), SPAB(N, M_minim, b,c), zeros(1, 10), SPAB(N, M_maxim, b,c), zeros(1, 10), 0.4*ones(1, 70)];
function [sp] = SPAB(N, M_minim,b,c)
a = [10,10];
%U = [zeros(1,10), SPAB(3,200, -0.7,0.7), zeros(1, 10), SPAB(10, 200, -0.7,0.7)];
if M_minim == 3
    a(1) = 1;
    a(3) = 1;
elseif M_minim == 4
    a(1) = 1;
    a(4) = 1;
elseif M_minim == 5
    a(2) = 1;
    a(5) = 1;
elseif M_minim == 6
    a(1) = 1;
    a(6) = 1;
elseif M_minim == 7
    a(1) = 1;
    a(7) = 1;
elseif M_minim == 8
    a(1) = 1;
    a(2) = 1;
    a(7) = 1;
    a(8) = 1;
elseif M_minim == 9
    a(4) = 1;
    a(9) = 1;
elseif M_minim == 10
    a(3) = 1;
    a(10) = 1;
end
x = ones(1,3);
x2 = zeros(1,3);

for j = 1 : N
    %x = x2
   x2(1) = mod(sum(a.*x),2);
   x2(2:end) = x(1:end-1);
   sp(j) = x2(1);
   x = x2;
    end
    
    sp = b+(c-b)*U;

end

