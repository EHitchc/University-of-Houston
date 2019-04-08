clc; clear workspace; close all;

%% Task B
x = [0	0.24	0.43	0.56	0.81	1.01	1.25	1.45	1.58	1.81	1.97	2.25	2.45	2.62	2.83	3.04	3.23	3.44	3.54	3.79	4	4.22	4.48	4.63	4.76	5.09	5.26	5.46];
y = [5.094	5.095	5.095	5.095	5.095	5.089	4.966	4.534	4.009	2.657	1.531	0.3654	0.2778	0.2385	0.2081	0.1861	0.1714	0.1583	0.1534	0.1423	0.1343	0.1274	0.1208	0.1171	0.1144	0.1083	0.1062	0.1024];

figure
plot(x,y, 'b-');
title('Resistively Loaded NMOS Inverter');
xlabel('Vin [V]');
ylabel('Vout [V]');

grid on;

%% Task B - Calculated
x = [0 .91 2.0063 5];
y = [5 5 1.0963 .1723];
figure 
plot(x,y, 'b');
title('Resistively Loaded NMOS Inverter');
xlabel('Vin [V]');
ylabel('Vout [V]');

grid on;
    
%% Task C
x = [0	0.19	0.37	0.64	0.81	1.05	1.24	1.47	1.67	1.82	2.01	2.28	2.45	2.65	2.81	3.05	3.21	3.39	3.58	3.82	3.99	4.19	4.4	4.63	4.84	5.03	5.26	5.44];
y = [2.229	2.229	2.229	2.229	2.225	2.167	2.072	1.956	1.852	1.776	1.679	1.534	1.442	1.343	1.261	1.149	1.0815	1.0211	0.9675	0.9151	0.885	0.8546	0.827	0.8018	0.7804	0.7643	0.7464	0.7334];

figure
plot(x,y, 'b-');
title('Enhancement-Load NMOS Inverter');
xlabel('Vin [V]');
ylabel('Vout [V]');

grid on;

%% Task C - Calculated
x = [0 .91 2.955 5];
y = [4.09 4.09 2.045 1.198];
figure 
plot(x,y, 'b');
title('Resistively Loaded NMOS Inverter');
xlabel('Vin [V]');
ylabel('Vout [V]');

grid on;
    