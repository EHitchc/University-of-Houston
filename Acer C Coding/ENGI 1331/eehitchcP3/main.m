%ENGI 1331 Project 3 - Ethan Hitchcock - eehitchc
clear all, close all, clc;
disp('ENGI 1331 Project 3 - Ethan Hitchcock - eehitchc');


%Problem 1 - Plotting Functions, Intersection Points, Area
disp(' '), disp(' '), disp('     Problem 1 - Plotting Functions, Intersection Points, Area'), disp(' ');


%Task 1
disp('Task 1:');
%Load in the coefficients for F1 and then plot F1 and F2 over the domain -8
%to 10 in Figure 1
disp('Load in the coefficients for F1 and then plot F1 and F2 over the domain -8 to 10 in Figure 1'), disp(' ');
C = load('coefficients.txt');
domain1 = -8;
domain2 = 10;
x = domain1:0.05:domain2;
F1 = polyval(C,x);
F2 = MyFun(x);
figure(1), plot(x,F1,x,F2), grid ON;
title('Figure 1'), xlabel('X Axis'), ylabel('Y Axis'), legend('F1(x)','F2(x)');
disp('Figure 1 displayed, Press any key to continue'), disp(' '), pause;


%Task 2
disp(' '), disp('Task 2:');
%Calculate all the intersection points of the two functions across the
%domain -8 to 10
disp('Calculate all the intersection points of the two functions across the domain -8 to 10');
x_int = Intersections(C, x)

%Using the found x values for the intersection points, calculate the y co-ordinates
%of the intersection points
disp('Using the found x values for the intersection points, calculate the y co-ordinates of the intersection points');
y_int = MyFun(x_int)

%Plot the graph of F1 and F2 including intercepts and name this Figure 2
disp('Plot the graph of F1 and F2 including intercepts and name this Figure 2'), disp(' ');
figure(2), plot(x,F1,x,F2), grid ON;
title('Figure 2'), xlabel('X Axis'), ylabel('Y Axis');
hold on;
scatter(x_int,y_int,'bp'), legend('F1(x)','F2(x)','Intersection');
hold off;
disp('Figure 2 displayed, Press any key to continue'), disp(' '), pause;


%Task 3
disp(' '), disp('Task 3:');
%Calculate the areas between intersection points using integrals and
%Riemann sums
disp('Calculate the areas between intersection points using integrals and Riemann sums'), disp(' ');
areas = AreaFunctions(C,x_int);

%Calculate the areas between intersection points using Riemann sums
disp(' '), disp('Calculate the areas between intersection points using Riemann sums'), disp(' ');
%Specify 4 incremental areas for function 
numincrements=4;
[areasL, areasM, areasR] = RiemannAreas(C,x_int,numincrements);

%Display the areas: integral, left Riemann sum, middle Riemann sum, and
%right Riemann sum
disp(' '), disp('The area for the integral, left Riemann sum, middle Riemann sum and right Riemann sum for each section are displayed below');
for a=1:length(x_int)-1
    fprintf('\n section %d: \n Integral: %f\n Left Riemann sum: %f\n Middle Riemann sum: %f\n Right Riemann sum: %f\n', a, areas(a), areasL(a), areasM(a), areasR(a));
end
disp(' '), disp('Press any key to continue'), disp(' '), pause;


%Task 4
disp(' '), disp('Task 4:');
%Find the x and y co-ordinates of the minimum of F1
disp('Find the x and y co-ordinates of the minimum of F1');
[F1_min_x, F1_min_y] = fminbnd(@(x) polyval(C,x), domain1, domain2)

%Find the intersections to the left and to the right of the minimum on F1
disp(' '), disp('Find the intersections to the left and to the right of the minimum on F1');
%left_ints and right_ints set to a value outside domain to account for
%cases where there is no intersection to the left or right of the minimum
%for F1 inside the domain
left_ints=domain1-1;
right_ints=domain2+1;
m=1;
for a=1:length(x_int)
    if x_int(a)<F1_min_x
        left_ints(a)=x_int(a);
    elseif x_int(a)>F1_min_x
        right_ints(m)=x_int(a);
        m=m+1;
    end
end

%Calculate the x and y co-ordinates of the intersection to the left of the
%minimum with the greatest difference in y values
disp(' '), disp('Calculate the x and y co-ordinates of the intersection to the left of the minimum with the greatest difference in y values');
y_dist=0;
%if no intersection to left of minimum for F1 do nothing
if left_ints==domain1-1
else
    for a=1:length(left_ints)
        if (MyFun(left_ints(a))-F1_min_y)>y_dist
            y_dist=MyFun(left_ints(a))-F1_min_y;
            xleft_int=left_ints(a);
            yleft_int=MyFun(left_ints(a));
        end
    end
end

%Calculate the x and y co-ordinates of the intersection to the right of the
%minimum with the greatest different in y values
disp(' '), disp('Calculate the x and y co-ordinates of the intersection to the right of the minimum with the greatest difference in y values');
y_dist=0;
if right_ints==domain2+1
else
    for a=1:length(right_ints)
        if(MyFun(right_ints(a))-F1_min_y)>y_dist
            y_dist=MyFun(right_ints(a))-F1_min_y;
            xright_int=right_ints(a);
            yright_int=MyFun(right_ints(a));
        end
    end
end

%Display the x and y co-ordinates of the point to the left and to the right
%of the minimum with the greatest difference in y values
disp(' '), disp('Display the x and y co-ordinates of the point to the left and to the right of the minimum with the greatest difference in y values'), disp(' ');
%left
if left_ints==domain1-1
    fprintf('There is no intersection to the left of the minimum within the domain\n');
else
    fprintf('Left: x:%f, y:%f\n', xleft_int, yleft_int);
end
%right
if right_ints==domain2+1
    fprintf('There is no intersection to the right of the minimum within the domain\n');
else 
    fprintf('Right: x:%f, y:%f\n', xright_int, yright_int);
end
disp(' '), disp('Press any key to continue'), disp(' '), pause;


%Task 5
disp(' '), disp('Task 5:');
%Fill the areas between F1 and F2 with colours rotating through the string
%"rgbymck" and label this Figure 3
disp('Fill the areas between F1 and F2 with colours rotating through the string "rgbymck" and label this Figure 3');
figure(3), plot(x,F1,x,F2), grid ON;
title('Figure 3'), xlabel('X Axis'), ylabel('Y Axis'), legend('F1(x)','F2(x)');
FillPlot(C,x_int);
disp(' '), disp('Figure 3 displayed, Press any key to continue'), disp(' '), pause;


%Problem 2 - Compatibility Test
disp(' '), disp('     Problem 2 - Compatibility Test'), disp(' ');


%Task 1
disp('Task 1:');
%Load in the data from the survey
disp('Load in the data from the survey'), disp(' ');
survey = load('survey_answer.csv');

%Ask the user to input a student's numerical identifier (101-120,
%201-214, 301-347, 401-423
disp('Ask the user to input a student''s numerical identifier (101-120, 201-214, 301-347, 401-423)');
student_id = input('     Input student ID     ');

%search for students data within the survey and output corresponding
%answers
disp(' '), disp('search for students data within the survey and output corresponding answers');
[rows,columns]=size(survey);
for a=1:columns
    if survey(1,a)==student_id
        student_id = survey(:,a)
    end
end
disp('Press any key to continue'), disp(' '), pause;


%Task 2
disp('task 2:');
%Create a function called "SAM.m" which calculates the spectral angle
%between vectors A and B
disp('Create a function called "SAM.m" which calculates the spectral angle between vectors A and B'), disp(' ');

%Create a function called "Euclidean.m" which calculates the Euclidean
%distance between vectors A and B
disp('Create a function called "Euclidean.m" which calculates the Euclidean distance between vectors A and B'), disp(' ');
disp('Press any key to continue'), disp(' '), pause;


%Task 3
disp('Task 3:');
%Compare the inputted student's answers with those of the other students
disp('Compare the inputted student''s answers with those of the other students'), disp(' ');
[SAMMostCompat, SAMLeastCompat, SAMMostCompatSect, SAMLeastCompatSect] = SAMComp(student_id,survey);
[EucMostCompat, EucLeastCompat, EucMostCompatSect, EucLeastCompatSect] = EuclideanComp(student_id,survey);
SAMComparisons = [SAMMostCompat, SAMLeastCompat, SAMMostCompatSect, SAMLeastCompatSect];
EucComparisons = [EucMostCompat, EucLeastCompat, EucMostCompatSect, EucLeastCompatSect];

%Display the results for both SAM test and Euclidean distance test
fprintf('\n SAM: \n Most Compatible Overall: %d \n Least Compatible Overall: %d \n Most Compatible Section: %d \n Least Compatible Section: %d \n', SAMComparisons);
fprintf('\n Euclidean: \n Most Compatible Overall: %d \n Least Compatible Overall: %d \n Most Compatible Section: %d \n Least Compatible Section: %d \n', EucComparisons);

%Do the two methods give different results?
disp(' '), disp('Do the two methods give different results?');
disp('   Yes but sometimes the two methods will return the same student IDs for each test');

%Which one would you recommend as a measurement of similarity between two vectors? 
disp(' '), disp('Which one would you recommend as a measurement of similarity between two vectors?');
disp('   Spectral Angle Mapper seems to place a weighting on each of the questions and their responses, however, the Euclidean distance measure can be offset by a large difference in a single response');

disp(' '), disp('Script for Project 3 complete, Press any key to end.'), pause;