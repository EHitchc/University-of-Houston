clc; clear workspace; close all;

%% Constants
k = 2 * pi(); %wave number in air

%% Array Factor for a single Element
N = 1; %the number of elements in the array
psi = pi()/180 * 0; %relative phase difference between two adjacent elements in radians
d = 1/4; %the spacing in wavelengths

phi = 90; 
theta = -180:.01:180;

THETA_PLOT(k, N, psi, d, phi, theta);

%% Array Factor for increasing number of Elements
% Constants
psi = pi()/180 * 0; %relative phase difference between two adjacent elements in radians
d = 1/4; %the spacing in wavelengths

phi = 90; 
theta = -180:.01:180;

for N = 2 : 2 : 10
    THETA_PLOT(k, N, psi, d, phi, theta);
end

%% Array Factor for increasing d
% Constants
N = 2; %the number of elements in the array
psi = pi()/180 * 0; %relative phase difference between two adjacent elements in radians

phi = 90; 
theta = -180:.01:180;

a = [1/16 1/8 1/4 1/2 1 2 4];
for d = 1 : 7
  
    THETA_PLOT(k, N, psi, a(d), phi, theta);
end

%% Array Factor for increasing relative phase difference
% Constants
N = 2; %the number of elements in the array
d = 1/4; %the spacing in wavelengths

phi = 90; 
theta = -180:.01:180;

b = -150 : 30 : 180;
for i = 1:length(b)
    psi = pi()/180 * b(i);
    THETA_PLOT(k, N, psi, d, phi, theta);
end

%% Array Factor for increasing phi
% Constants
N = 2; %the number of elements in the array
psi = pi()/180 * 0; %relative phase difference between two adjacent elements in radians
d = 1/4; %the spacing in wavelengths

phi = 30:30:180; 
theta = -180:.01:180;

for i = 1:length(phi)
    THETA_PLOT(k, N, psi, d, phi(i), theta);
end