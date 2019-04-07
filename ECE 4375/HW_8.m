clear; clc; close all;

p = -25;
K = 82.50;
num = [100 100*K];
den = [1 125+p 100*K+25*p];
G = tf(num,den)
step(G);
xlabel('Time(secs)')
ylabel('y(t)')
title('Unit-step responses of the system')
pause;

%%
clear; clc; close all;

K=2000;
a=10;
num = [];
den = [-10+10i -10-10i -a];
G = zpk(num,den,K)
step(G);
xlabel('Time(secs)')
ylabel('y(t)')
title('Unit-step responses of the system')
pause;

%%
clear; clc; close all;

syms Kd Kp Kv s;
num = 1000*Kd*s + 1000*Kp;
den = s*(s + 10);
G = num/den;
Kv = s*G;
s = 0;
Kv = eval(Kv)

Kp=10;
clear s;
syms s;
Mnum=(Kp+Kd*s)*1000/s/(s+10);
Mden=1+(Kp+Kd*s)*1000/s/(s+10);
simplify(Mden/Mnum);

%a
C = 0.5;
solve(10+1000*Kd-2*100*C)

%b
C = 0.707;
solve(10+1000*Kd-2*100*C)

%c
C = 1.0;
solve(10+1000*Kd-2*100*C)
