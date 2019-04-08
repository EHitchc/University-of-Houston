clc; clear workspace; close all;

%% CMOS Transmission Gate

% Vin = 0[v]

x = [0
1
2
3
4
5];
y = [0.00516
0.0242
0.02492
0.02498
0.02503
0.02509];

figure
plot(x,y, 'y-');
title('CMOS Transmission Gate');
xlabel('A Gate Voltage [V]');
ylabel('Vout [mA]');

grid on; hold on;

% Vin = 1[v]

x = [0
1
2
3
4
5];
y = [0.00374
0.0828
0.5019
1.0106
1.0649
1.06499];

plot(x,y, 'm-');

% Vin = 2[v]

x = [0
1
2
3
4
5];
y = [0.00394
2.003
2.0168
2.0163
2.0158
2.0554];

plot(x,y, 'c-');

% Vin = 3[v]

x = [0
1
2
3
4
5];
y = [0.00483
3.1107
3.1106
3.1105
3.1105
3.1105];

plot(x,y, 'r-');

% Vin = 4[v]

x = [0
1
2
3
4
5];
y = [0.00401
4.2062
4.1406
4.1405
4.1404
4.1405];

plot(x,y, 'g-');

% Vin = 5[v]

x = [0
1
2
3
4
5];
y = [0.00531
5.0743
5.074
5.074
5.0739
5.0738];


plot(x,y, 'b-');
