%% clear workspace
clc; clear; close all;

%% Q4
%% Part a)
GPA = load('data.mat');

% handle data
GPAG = graph(GPA.adjacency);

% plot on graph
GPAPlot = plot(GPAG, 'Layout', 'force');
title('Network for High School Students');

% highlight high GPA in green
highlight(GPAPlot, find(GPA.gpa == 2), 'NodeColor', 'g');

display('Graph displayed, press any key to resume');
pause();

%% Part b)
%Number of paths of length 2 in graph
deg = degree(GPAG);
%find nodes with more than 1 edge
mask = find(deg > 1);
%find number of pairs
pairs = zeros(size(deg));
pairs(mask) = deg(mask).*(deg(mask)-1)/2;
NoPair = sum(pairs);

%Number of repeat triangles in graph (divided by 2 to account for symmetry
%of adjacency matrix)
Tri = diag(GPA.adjacency^3)/2;
%Total number of unique triangles (divided by 3 to avoid repeats)
NoTri = sum(Tri)/3;

fprintf("\rNumber of paths of length 2: %d\r", NoPair);
fprintf("Number of closed triangles: %d\r\r", NoTri);
pause();

%% Part c)
cluster = zeros(size(deg));
% cluster coefficient for each node (#triangles/#triples)
cluster(mask) = Tri(mask)./pairs(mask);
% average for network
clusterCoeff = mean(cluster);

fprintf("Cluster Coefficient: %.4f\r\r", clusterCoeff);
pause();

%% Part d)
% cluster coefficient for this network is relatively low at 0.2212. This is
% likely due to the separation of friend groups at high school. While
% people may be acquainted with one another, they are not required to hold
% a friendship/friend group with one another, and as such there is a low
% cluster coefficient.

%% Part e)
% mask of High GPA students
highGPA = find(GPA.gpa == 2);
% size of mask for number of High GPA students
noHighGPA = size(highGPA, 1);
noTotalStudents = size(GPA.gpa, 1);

% fraction high-performing students
p = noHighGPA/noTotalStudents;

% this implies the probability of a link between a high and low performing
% student will be 2*p*(1-p)
pLink = 2*p*(1-p);

fprintf("Probability of a link between a high and low performing student: %.4f\r\r", pLink);
pause();

%% Part f)
% mask of Low GPA students
lowGPA = find(GPA.gpa == 1);

% total edges in network
totalEdges = numedges(GPAG);

% Homophily for low GPA
lowGPAG = subgraph(GPAG, lowGPA);
lowEdges = numedges(lowGPAG);

% Homophily for high GPA
highGPAG = subgraph(GPAG, highGPA);
highEdges = numedges(highGPAG);

% Fraction of cross-class edges
fractionCrossClass = (totalEdges - lowEdges - highEdges)/totalEdges;

fprintf("Actual fraction for link between a high and low performing student: %.4f\r\r", fractionCrossClass);
pause();
