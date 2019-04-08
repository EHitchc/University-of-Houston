clc; clear all; close all;

r=[1:.2:5];
h=r;
[V,Sa]=Cone(h,r);

figure(1);
plot(r,V); grid on; title('Volume vs Height-Radius');
xlabel('Height-Radius (cm)'); ylabel('Volume (cm^3)');