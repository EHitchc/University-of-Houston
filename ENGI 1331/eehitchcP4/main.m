%ENGI 1331 Project 4 - Ethan Hitchcock - eehitchc
clc, clear all, close all;
disp('ENGI 1331 Project 4 - Ethan Hitchcock - eehitchc');

%% Problem 1

%Problem 1 - Ammonia Production
disp(' '), disp(' '), disp('Problem 1 - Ammonia Production'), disp(' ');

%Task 1 - Applying Mass Balances
disp('Task 1 - Applying Mass Balances')
%Input values for XI0, fsp, and yp
XI0 = input('XI0:   ');
fsp = input('fsp:   ');
yp = input ('yp:   ');

%Use user defined function so solve for total moles fed into reactor, total
%moles of product and fractional conversion of ammonia
[nr, np, fov] = ChemPro(XI0, fsp, yp);
fprintf('\n nr: %f\n np: %f\n fov: %f\n', nr, np, fov);

disp(' '), disp('Press any key to continue...'), pause;

%Task 2 - Graphically analyzing the system
disp(' '), disp('Task 2 - Graphically analyzing the system')

%Vary yp from .01 to 1 and graph in figure 1
yp1 = linspace(.01,1,200);
[nr1, np1, fov1] = ChemPro(XI0, fsp, yp1);

disp(' '), disp('Figure 1, np vs yp, displayed')
figure(1);
plot(yp1, np1);
title('Figure 1');
xlabel('yp'); ylabel('np');
disp('the amount of ammonia produced decreases with an increasing purge ratio, the relationship is nonlinear and concave up')
disp('Press any key to see figure 2...'), pause;

%Vary fsp from .01 to 1 and graph in figure 2
fsp2 = linspace(.01,1,200);
[nr2, np2, fov2] = ChemPro(XI0, fsp2, yp);

disp(' '), disp('Figure 2, np vs fsp, displayed')
figure(2);
plot(fsp2, np2);
title('Figure 2');
xlabel('fsp'); ylabel('np');
disp('the amount of ammonia produced increases with an increasing single pass conversion ratio, the relationship is nonlinear and concave down');
disp('Press any key to see figure 3...'), pause;

%Vary XI0 from 0 to .99 and graph in figure 3
XI03 = linspace(0,.99,200);
[nr3, np3, fov3] = ChemPro(XI03, fsp, yp);

disp(' '), disp('Figure 3, np vs XI0, displayed')
figure(3);
plot(XI03, np3);
title('Figure 3');
xlabel('XI0'); ylabel('np');
disp('the amount of ammonia produced decreases linearly with an increase in inert gas being fed into the system');

disp(' '), disp('Press any key to continue...'), pause;

%Task 3 - Optimizing the system
disp(' '), disp('Task 3 - Optimizing the system')

%Statement about maximising np
disp(' '), disp('In order to maximise production of ammonia, maximise fsp, minimise yp and minimise XI0');

%Find maximum theoretical production of ammonia
[a, tmax] = ChemPro(XI03(find(max(np1)==np1)), fsp2(find(max(np2)==np2)), yp1(find(max(np3)==np3)));
fprintf('\nTheoretical maximum production of ammonia is %f moles\n', tmax);

%Explanation for relationships
fprintf('\n   np vs XI0:\nThe amount of inert gas fed into the system decreases the ammonia production linearly because the inert gas does not react to form ammonia\n   np vs fsp:\nnp increases with an increase in fsp due to more ammonia being produced as the gases pass through the reactor\n   np vs yp:\nnp decreases with an increase in yp as an increased purge ratio means fewer moles of gas passing through reactor\n');
disp(' '), disp('Press any key to continue to Problem 2.'), pause;

%% Problem 2

%Problem 2 - Circuit Analysis
disp(' '), disp(' '), disp('Problem 2 - Circuit Analysis'), disp(' ');
 
%Task 1 - Applying Kirchoff's Laws
disp(' '), disp('Task 1 - Applying Kirchoff''s Laws')
%Get values from VR function
[V1,V2,R1,R2,R3] = VR();

%Use CircuitSolver function to solve for I1, I2, and I3
[I1, I2, I3] = CircuitSolver(V1, V2, R1, R2, R3);

%Create matrix using values from CircuitSolver and display
Circuit = [V1, R1, I1; V2, R2, I2; 0, R3, I3];
printmat(Circuit, 'Circuit values', '1 2 3', 'Voltage Resistance Current');

disp(' '), disp('Press any key to continue...'), pause;

%Task 2 - Current Effects on Voltage
disp(' '), disp('Task 2 - Current Effects on Voltage');

%Create a voltage vector for use in finding min and max currents
V2_new = linspace(-500,500,5000);

%Create vectors for I1, I2 and I3 with corresponding voltage
[I1_new, I2_new, I3_new] = CircuitSolver(V1, V2_new, R1, R2, R3);

%While the current flowing through any of the resistors (in any direction)
%is greater than 1 this loop will run, however, when the current through
%all resistors drops below 1, the while loop ends.

%This while loop starts from V2_new(5000) and works backwards to find max_V2
i=length(V2_new);
while abs(I1_new(i))>1 || abs(I2_new(i))>1 || abs(I3_new(i))>1
    i=i-1;
end
max_V2 = V2_new(i);
 
%This while loop starts from V2_new(1) and works forwards to find min_V2
j=1;
while abs(I1_new(j))>1 || abs(I2_new(j))>1 || abs(I3_new(j))>1
    j=j+1;
end
min_V2 = V2_new(j);

fprintf('\n   Minimum value for V2: %f\n   Maximum value for V2: %f\n', min_V2, max_V2);

disp(' '), disp('Press any key to continue...'), pause;

%Task 3 - Resistance Effects on Voltage
disp(' '), disp('Task 3 - Resistance Effects on Voltage');

%Create a resistance vector from 15 to 115
R3_new = linspace(15,115,100);
 
%Create arrays for the circuit using varied value of V2 and R3
for k=1:length(R3_new)
    [I1_nu(k,:), I2_nu(k,:), I3_nu(k,:)] = CircuitSolver(V1, V2_new, R1, R2, R3_new(k));
end
 
%Same logic as Task 2, however, max_V2 is now assigned to a vector
for k=1:length(R3_new)
    i=length(V2_new);
    while abs(I1_nu(k,i))>1 || abs(I2_nu(k,i))>1 || abs(I3_nu(k,i))>1
        i=i-1;
    end
    maxV2(k)=V2_new(i);
end
 
%Same logic as Task 2, however, min_V2 is now assigned to a vector
for k=1:length(R3_new)
    i=1;
    while abs(I1_nu(k,i))>1 || abs(I2_nu(k,i))>1 || abs(I3_nu(k,i))>1
        i=i+1;
    end
    minV2(k)=V2_new(i);
end
 
%Calculate the average Voltage range
V_Range = maxV2 - minV2;
avgV_Range = mean(V_Range);
fprintf('\nThe average voltage range is: %f', avgV_Range);

%Plot graph of Max/Min Voltage vs Resistance
figure(4);
grid on
plot(R3_new,maxV2,R3_new,minV2);
title('Maximum and Minimum voltage (V2) vs Resistance (R3)')
xlabel('Resistance (R3)'); ylabel('Voltage (V2)');
legend('Maximum V2', 'Minimum V2');

disp(' '), disp('Figure 4 displayed. Press any key to continue Task 3...'), pause;
disp(' '), disp('What is the relationship between voltage and resistance?');
disp('   The graphs show that as the resistance increases, the absolute value of the voltage increases (but nonlinearly)')
disp(' '), disp('What would you look for in optimizing the voltage range for the circuit?');
disp('   An increased R3 value.');

disp(' '), disp('Press any key to continue to Problem 3...'), pause;

%% 

%Problem 3 - Static Equilibrium
disp(' '), disp(' '), disp('Problem 3 - Static Equilibrium'), disp(' ');

%Task 1 - Setting up the problem
disp('Task 1 - Setting up the problem'), disp(' ');
%x-axis forces: Fx-Tcos(theta)=0
%y-axis forces: Fy+Tsin(theta)-mg=0
%moments about hinge: Tsin(theta)L-mgL/2=0
%theta = arctan(D/L)

%input values for m, L, and D
m = input('Value for mass, m:   ');
L = input('Value for length of beam, L:   ');
D = input('Value for distance from hinge to cable attached to wall, D:   ');

%Use User Defined Function to solve linear equations
[Fx, Fy, T] = BeamSolver(m, L, D);
fprintf('\n   Fx: %f\n   Fy: %f\n   T: %f\n', Fx, Fy, T);

disp(' '), disp('Press any key to continue...'), pause;

%Task 2 - Plotting the forces
disp(' '), disp('Task 2 - Plotting the forces');

figure(5);

%plot of varying mass
m_var = linspace(0,500,2000);
for i=1:length(m_var)
    [Fxm(i), Fym(i), Tm(i)] = BeamSolver(m_var(i), L, D);
end
subplot(1,2,1); plot(m_var, Fxm, '-', m_var, Fym, '--', m_var, Tm, '-.'); grid on;
title('Variable Mass'); xlabel('Mass'); ylabel('Force');
legend('Fx', 'Fy', 'T');

%plot of varying length
L_var = linspace(0.1,20,200);
for i=1:length(L_var)
    [FxL(i), FyL(i), TL(i)] = BeamSolver(m, L_var(i), D);
end
subplot(1,2,2); plot(L_var, FxL, '-', L_var, FyL, '--', L_var, TL, '-.'); grid on;
title('Variable Length'); xlabel('Length'); ylabel('Force');
legend('Fx', 'Fy', 'T');

disp(' '), disp('Figure 5 displayed');

disp(' '), disp('     Variable Mass:');
disp('How is each force affected by the change in m?');
disp('  Each force increases as mass increases.');
disp('Which forces are affected most and least? Why?');
disp('  As Fx and Fy are forces dependent on the value of the tension in the cable, they are not affected as much as T');

disp(' '), disp('     Variable Length');
disp('How is each force affected by the change in L?');
disp('  Fy is independent of length. Fx and T increase as length increases');
disp('Which forces are affected most and least? Why?');
disp('  There is no affect on Fy. T experiences an exponential increase at small lengths but then shares a similar rate of increase in force with Fx at larger lengths');

disp(' '), disp('Press any key to continue...'), pause;

%Task 3 - Maximum weight
disp(' '), disp('Task 3 - Maximum weight');

%initialise variables
T_var=0;
m_T3=0;
%when the Tension force reaches 5000 the while loop will end and give the
%value for the maximum weight
while T_var<5000
    m_T3=m_T3 + .01;
    [Fx3, Fy3, T_var] = BeamSolver(m_T3, L, D);
end

fprintf('\nThe maximum weight assuming all other values remain the same is: %f\n', m_T3);
disp(' '), disp('Press any key to continue...'), pause;

%Task 4 - Length vs. Maximum Weight
disp(' '), disp('Task 4 - Length vs. Maximum Weight');

%Note: L_var defined in Task 2
%For each length perform process in task 3 and then save to vector max_m
for i=1:length(L_var)
    m_T4=0;
    T_var4=0;
    while T_var4<5000
        m_T4=m_T4 + .1;
        [Fx4, Fy4, T_var4] = BeamSolver(m_T4, L_var(i), D);
    end
    max_m(i)=m_T4;
end

figure(6);
plot(max_m, L_var);
grid on;
title('Length (L) vs Mass (m)'); xlabel('Mass (m)'); ylabel('Length (L)');

disp(' '), disp('Figure 6 displayed.');

disp(' '), disp('Press any key to end script.'), pause;