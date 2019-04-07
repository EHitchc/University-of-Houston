clc; clear all; close all;

syms s t

%% 3.15a)
display('3.15a)');

num = [10, 10];
den = [1, 10, 24, 0, 0];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)

%% 3.15b)
display('3.15b)');

num = [1, 1];
den = [1, 4, 6, 4, 0];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)

%% 3.15c)
display('3.15c)');

num = [5, 10];
den = [1, 6, 5, 0, 0];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)

%% 3.15d)
display('3.15d)');

num = [5];
den = [1, 2, 2, 1];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace((exp(-2*s)*snum)/sden)

%% 3.15e)
display('3.15e)');

num = [100, 100, 300];
den = [1, 5, 3, 0];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)

%% 3.15f)
display('3.15f)');

num = [1];
den = [1, 1, 1.25, 1, 0.25, 0];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)

%% 3.15g)
display('3.15g)');

num = [2, 1, 8, 6];
den = [1, 2, 6, 8, 8];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)

%% 3.15h)
display('3.15h)');

num = [2, 9, 15, 1, 2];
den = [1, 4, 5, 2, 0, 0];
FT = tf(num,den);

snum = poly2sym(num, s);
sden = poly2sym(den, s);
FT_time_domain = ilaplace(snum/sden)