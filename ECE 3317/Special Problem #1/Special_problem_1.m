clc, clear all, close all;

Eo = 8.85 * 10^(-12);
Mo = 4 * pi() * 10^(-7);

%adjust these for differing curves
Er = 81;
Mr = 1;
o = 20;

E = Eo * Er;
M = Mo * Mr;
%representation of o/wE
x = [0.1 : 0.01 : 100];
%corresponding w
w = (x .* E/o).^(-1);

hold on;

%plots for actual values
k = w .* sqrt(M * E) .* sqrt(1 + j().*x);
kR = real(k);
kI = imag(k);

semilogx(x, kR, 'r');
semilogx(x, kI, 'g');

%plots for good estimate Dielectric
kRestDiel = w .* sqrt(M * E);
kIestDiel = o/2 * sqrt(M/E);

semilogx(x, kRestDiel, '--b');
plot([x(1) x(end)], [kIestDiel kIestDiel], '--k');

%plots for good estimate Conductor
kRestCond = sqrt(w.*M.*o./2);
kIestCond = kRestCond;

semilogx(x, kRestCond, ':y');
semilogx(x, kIestCond, ':m');

%format plot
set(gca, 'xscale', 'log');
axis([-inf inf 0 1000]);

hold off;

%plots for actual values
figure;
hold on;
semilogx(x, kR, 'r');
semilogx(x, kI, 'g');
set(gca, 'xscale', 'log');
axis([-inf inf 0 1000]);
hold off;

%good estimate Dielectric alone
figure;
hold on;
semilogx(x, kRestDiel, '--b');
plot([x(1) x(end)], [kIestDiel kIestDiel], '--k');
set(gca, 'xscale', 'log');
axis([-inf inf 0 1000]);
hold off;

%good estimate Conductor alone
figure;
hold on;
semilogx(x, kRestCond, ':y');
semilogx(x, kIestCond, ':m');
set(gca, 'xscale', 'log');
axis([-inf inf 0 1000]);
hold off;

% %error good conductor
errorkRconduct = (kRestCond - kR)./kR * 100;
errorkIconduct = (kIestCond - kI)./kI * 100;

figure;
hold on;
semilogx(x, abs(errorkRconduct), 'b');
semilogx(x, abs(errorkIconduct), 'm');
set(gca, 'xscale', 'log');
axis([-inf inf 0 200]);
hold off;

% %error good dielectric
% %error good conductor
errorkRdiel = (kRestDiel - kR)./kR * 100;
errorkIdiel = (kIestDiel - kI)./kI * 100;

figure;
hold on;
semilogx(x, abs(errorkRdiel), 'b');
semilogx(x, abs(errorkIdiel), 'm');
set(gca, 'xscale', 'log');
axis([-inf inf 0 200]);
hold off;