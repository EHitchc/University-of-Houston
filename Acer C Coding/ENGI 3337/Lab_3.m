Vo = [-20 : 1 : 20];
Vr = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.496 1.45 2.43 3.42 4.40 5.40 6.40 7.40 8.40 9.39 10.4 11.4 12.4 13.4 14.4 15.4 16.4 17.4 18.4 19.4];
Vd = [-20.1 -19.1 -18.1 -17.1 -16.1 -15.1 -14.1 -13.1 -12.1 -11.1 -10.1 -9.08 -8.07 -7.06 -6.06 -5.06 -4.06 -3.05 -2.05 -1.04 0 0.546 0.599 0.624 0.641 0.653 0.662 0.670 0.671 0.683 0.688 0.692 0.697 0.700 0.704 0.707 0.710 0.712 0.715 0.717 0.720];

i = Vr ./ 0.978;

plot(Vo, Vd);
figure();
plot(Vo, i);