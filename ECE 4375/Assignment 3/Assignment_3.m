clc; clear all; close all;

%% 3.14(d)
syms s;

d1 = ilaplace(1/s)
d2 = ilaplace((-s+1)/(s^2+s+2))

%% 3.14(g)

g1 = 2*ilaplace(-1/(s+2))
g2 = 2*ilaplace(1/(s+1))
g3 = 2*ilaplace(exp(-s) * (2/(s+2)))
g4 = 2*ilaplace(exp(-s) * (- 1/(s+1)))
g5 = 4*ilaplace(exp(-2*s) * (1/(s+1)))
g6 = 4*ilaplace(exp(-2*s) * (-1/(s+2)))

%% 3.14(h)

h1 = -1/2 * ilaplace(1/(s+1))
h2 = 3 * ilaplace(1/(s+2))
h3 = -5/2 * ilaplace(1/(s+3))