clc; clear variables; close all;

%Initialisation
u = 4 * pi() * 10^(-7);
E = 8.8541878176 * 10^(-12);

f = 50 * 10^6;
w = 2 * pi() * f;
theta = 30 * pi()/180;
E0 = 1; %Electric field strength [V/m]
H0 = 1; %Magnetic field strength [A/m]

k0 = 2 .* pi() .* f .* sqrt(u * E);

x_neg = [-10 : 0.01 : 0];
x_pos = [0 : 0.01 : 4];
x = horzcat(x_neg, x_pos);

%% E/H vs. Z - Air -> Dielectric
%Functioning
Er1 = 1;
ur1 = 1;

Er2 = 4;
ur2 = 1;

%Perpendicular
PERPENDICULAR_POLAR( E0, u, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);
%Parallel
PARALLEL_POLAR( H0, E, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);

%% E/H vs. Z - Dielectric -> Air 
%Functioning
Er1 = 4;
ur1 = 1;

Er2 = 1;
ur2 = 1;

PERPENDICULAR_POLAR( E0, u, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);

%angle greater than Critical angle
theta_x = 60 * pi()/180;
PERPENDICULAR_POLAR( E0, u, w, theta_x, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);

%% E/H vs. Z - Air -> Dissipative Medium
%Functioning
Er1 = 1;
ur1 = 1;

o2 = 0.01;
Er2 = 10 - (o2/(w*E))*1i;
ur2 = 1;

PERPENDICULAR_POLAR( E0, u, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);

%% Brewster Angle
%Functioning
Er1 = 1;
ur1 = 1;

Er2 = 4;
ur2 = 1;

theta_b = atan(sqrt((Er2)/(Er1)));

PARALLEL_POLAR( H0, E, w, theta_b, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);

%% Skin Effect
%Functioning
o1 = 5.5 * 10^(-15);
Er1 = 1 - (o1/(w*E))*1i;
ur1 = 1;

o2 = 0.02;
Er2 = 4 - (o2/(w*E))*1i;
ur2 = 1;

k1 = k0 * sqrt(Er1 * ur1);
k2 = k0 * sqrt(Er2 * ur2);

kx = k1 .* sin(theta);
kz = k1 .* cos(theta);

ktz = sqrt(k2^2 - kx^2); 

R = (ur2*kz - ur1*ktz)/(ur2*kz+ur1*ktz);
T = 1 + R;

x_neg_mod = x_neg .* kz; %equivalent to kz * z

% E-field
y_neg_incident = E0 .* exp(-1i .* x_neg_mod);
y_neg_reflect = E0 .* R .* exp(1i .* x_neg_mod);
y_neg = abs(y_neg_incident + y_neg_reflect);
y_pos = abs(T .* E0 .* exp(-1i .* x_pos .* ktz));
y = horzcat (y_neg, y_pos);

figure();
set(gcf, 'pos', [1, 1, 800 ,600]);
subplot(2,1,1);
plot(x,y);
xlabel('z [m]');
ylabel('|Ey| in [V/m]');
title('Plot of E-field vs Z for Air -> Conductor (Er = 4,ur = 1,o = 0.02), Perpendicular Polarization');

grid on

% J-density
y_neg_incident = o1 .* E0 .* exp(-1i .* x_neg_mod);
y_neg_reflect = o1 .* E0 .* R .* exp(1i .* x_neg_mod);
y_neg = abs(y_neg_incident + y_neg_reflect);
y_pos = abs(o2 .* T .* E0 .* exp(-1i .* x_pos .* ktz));
y = horzcat (y_neg, y_pos);

subplot(2,1,2);
plot(x,y);
xlabel('z [m]');
ylabel('|Jy| in [V/m]');
title('Plot of Current Density vs Z for Air -> Conductor (Er = 4,ur = 1,o = 0.02), Perpendicular Polarization');

grid on

%% E/H vs. Z - Air -> Perfect Conductor
%Functioning
Er1 = 1;
ur1 = 1;

o2 = 1.7976e+290; %conductivity is high for perfect connductor
Er2 = 1.7976e+290 - (o2/(w*E))*1i; %Er2 is infinity for a perfect conductor, large value
ur2 = 2.2250e-290; %ur2 is 0 for a perfect conductor, 0+

%Perpendicular
PERPENDICULAR_POLAR( E0, u, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);
%Parallel
PARALLEL_POLAR( H0, E, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);

%% Evanescent Waves
%Functioning
Er1 = 1;
ur1 = 1;

wp = 2 * pi() * 9 * 10^6;
wt = wp/sqrt(5);
Er2 = (1 - wp^2/wt^2);
ur2 = 1;

PERPENDICULAR_POLAR( E0, u, wt, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x);


