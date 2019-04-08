% ENGI 1331 Project 1 - Ethan Hitchcock - eehitchc
clc; close; clear;
disp('ENGI 1331 Project 1 - Ethan Hitchcock - eehitchc');


% Problem 01 Cylindrical Optimisation Problem
disp(' '), disp(' '), disp('Problem 01 Cylindrical Optimisation Problem'), disp (' ');

% Task 1 - Import the data and name it orig_data
disp('Task 1 - Import the data and name it orig_data');
orig_data = load('data.csv')
disp('Press any key to continue'), pause;

% Task 2 - Create matrix, multiplier
disp('Task 2 - Create matrix, multiplier');
multiplier = [1,2,3;13,14,15;8,9,10]
disp('Press any key to continue'), pause;

% Task 3 - Multiply orig_data by multiplier, assign to new matrix, optimize
disp('Task 3 - Multiply orig_data by multiplier, assign to new matrix, optimize');
optimize = orig_data.*multiplier
disp('Press any key to continue'), pause;

% Task 4 - Subtract 15 from each value of optimize and assign absolute
% value of resultant matrix to variable optimize_r
disp('Task 4 - Subtract 15 from each value of optimize and assign absolute value of resultant matrix to variable optimize_r');
optimize_r = abs(optimize-15)
disp('Press any key to continue'), pause;

% Task 5 - Multiply all elements of optimize by 3/10 and assign absolute
% value of the resultant matrix to optimize_h
disp('Task 5 - Multiply all elements of optimize by 3/10 and assign absolute value of the resultant matrix to optimize_h');
optimize_h = abs(optimize.*(3/10))
disp('Press any key to continue'), pause;

% Task 6 - Utilise the 5 steps of problem solving to find the values of
% height h and base r that will maximize the volume of a cylinder
disp('Task 6 - Utilise the 5 steps of problem solving to find the values of height h and base r that will maximize the volume of a cylinder'), disp(' ');
% Step 1 - Define the Problem: What provided height h and base r will
% maximize the volume of a cylinder?
disp('Step 1 - Define the Problem: What provided height h and base r will maximize the volume of a cylinder?')
% Step 2 - Collect data
disp('Step 2 - Collect data'), disp('The used data is optimize_r and optimize_h');
% Step 3 - Create a Solution - Volume of a cylinder = pi*(r^2)*h
disp('Step 3 - Create a Solution'), disp('Volume of a cyclinder =pi*(r^2)*h');
% Step 4 - Implement a Solution
disp('Step 4 - Implement a Solution');
% Find the volume of each cylinder using element by element multiplication
disp('Find the volume of each cylinder using element by element multiplication');
volumecylinder = pi.*optimize_h.*optimize_r.^2
% a) Using sum(), find the average resulting volume. Assign it to the
% variable, avg_vol. numel returns number of elements in array
disp('a) Using sum(), find the average resulting volume. Assign it to the variable, avg_vol.');
avg_vol = (sum(sum(volumecylinder)))/numel(volumecylinder)
% b) Using max(), determine largest value in resultant matrix. Your answer
% will be a single value. Assign it to the variable, max_volume.
disp('b) Using max(), determine largest value in resultant matrix.');
max_volume = max(max(volumecylinder))
% c) Using find(), logical statement == ,and the power of indexing,
% determine the values in optimize_r and optimize_h that gave you the
% maximum volume. Note: ==, “equals,” means the program will go through and
% find the exact match of a value within a matrix 
disp('c) Using find(), logical statement == ,and the power of indexing, determine the values in optimize_r and optimize_h that gave you the maximum volume.');
max_r=optimize_r(find(volumecylinder==max_volume))
max_h=optimize_h(find(volumecylinder==max_volume))
% Step 5 - Verify Solution
disp('Step 5 - Verify solution'), disp('If test is equivalent to max_volume as above then solution is verified (test is volume calculated using max optimize_r and optimize_h as found previously)');
test = pi*max_r^2*max_h
disp('Press any key to output results'), pause;

% Output of results
disp(' '), disp('The radius which yielded the greatest volume was '),
disp(max_r), disp('The height which yielded the greatest volume was '),
disp(max_h), disp('The average volume was '), disp(avg_vol);

%Pause for input before problem 02
disp('Press any key to continue on to Problem 02');
pause;


% Problem 02 Volume Optimization Problem
disp(' '), disp(' '), disp('Problem 02 Volume Optimisation Problem'), disp (' ');
%Assign R = 4 for radius of sphere
R = 4;

% Step 1 - Define the problem: What is the volume of the largest right cone
% that can be incribed inside a sphere of radius 4?
disp('Step 1 - Define the problem: What is the volume of the largest right cone that can be inscribed inside a sphere of radius 4?'), disp(' ');

% Step 2 - Collect data
% The height of the cone is the independent variable
% The volume of the cone is the dependent variable
disp('Step 2 - Collect data'), disp('The height of the cone is the independent variable'), disp('The volume of the cone is the dependent variable'), disp(' ');
disp('Press any key to continue'), pause;

% Task 1 - Use linspace() to create an array, which spans a reasonable
% distance given the parameters of the problem above. This will represent
% your possible ("candidate") h ( height) values. Assign these values to
% the variable hval.
disp('Task 1 - Use linspace() to create an array, which spans a reasonable distance given the parameters of the problem above.  This will represent your possible (“candidate”) h (height) values.  Assign these values to the variable hval.');
hval = linspace(0,2*R,401);
disp('    hval suppressed as vector of 401 columns');
% assign relevant radius values to variable rval. Use pythagoras to
% determine radius values.
disp('assign corresponding radius for each height to vector rval. Radius is calculated using Pythagoras Theorem and the vector hval')
rval = sqrt(R^2-(hval-R).^2);
% assign first half of radius values in vector to 4 as max radius is 4 for
% any height less than 4
disp('assign first half of radius values in vector to 4 as max radius is 4 for any height less than 4');
rval(1:200) = R;
disp('    rval suppressed as vector of 401 columns');
disp('Press any key to continue'), disp(' '), pause;

% Step 3 - Generate a Solution: Volume = (1/3)*pi*radius^2*height
disp('Step 3 - Generate a Solution: Volume = (1/3)*pi*radius^2*height'), disp(' ');

%Step 4 - Implement a Solution
disp('Step 4 - Implement a Solution');
% Task 2 - Create an equation for the volume of the cone, and name it
% volume.
disp('Task 2 - Create an equation for the volume of the cone, and name it volume.');
volume = (1/3)*pi.*rval.^2.*hval;
disp('    volume suppressed as vector of 401 columns');
disp('Press any key to continue'), pause;

% Task 3 - Using the figure and plot functions, graph your height vs.
% volume function as Figure 1. 
disp('Task 3 - Using the figure and plot functions, graph your height vs. volume function as Figure 1.') 
figure(1);
plot(hval, volume);
% Wait for input before continuing
disp(' '), disp('See Figure 1 for Height vs. Volume. Press any key to continue.'), disp(' ');
pause;

% Task 4 - Use max() to determine the maximum value for volume and the
% corresponding height value which creates this volume.
disp('Task 4 - Use max() to determine the maximum value for volume and the corresponding height value which creates this volume.');
% Find the max volume and assign it to maxvol
maxvol = max(volume)
% Use maxvol to find the corresponding max height and assign it to maxhval
maxhval = hval(find(volume==maxvol))
disp('Press any key to continue'), pause;

%Step 5 - Verify
disp('Step 5 - Verify');
disp('If the volume of the sphere is more than the maxvol of the cone, solution is verified');
volume_sphere = (4/3)*pi*R^3
disp('Press any key to Output Results'), pause;

% Output of Results
disp(' '), disp('The maximum volume of the cone inscribed in a sphere of radius 4 is '),
disp(maxvol), disp('and the corresponding height is '), disp(maxhval);
