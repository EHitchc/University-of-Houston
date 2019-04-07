clc; clear; close all;
%% Q5
%% Part a
data = load('hw5data.mat');
G = digraph(data.adjacency);
plot1 = plot(G);

%% Part b
% Nodes 1-10 are plants and 11-22 are pollinators

%% Part c
[val m1 m2] = bipartite_matching(data.adjacency);
matching = [m1 m2]

% A max of 10 edges can be made as the bipartite graph is not perfectly
% matched, i.e. there is an unmatched number of plants to pollinators.
% Additionally, the bipartite_matching function matched such that there
% would be at least one pollinator assigned to each plant.

%% Part d
figure;
plot2 = plot(G);
highlight(plot2, [m1; m2], 'NodeColor', 'r');

%% Q6
%% Part a
% For an Erdos-Reyni model of random graphs, a giant component will begin
% to form when the mean degree of the vertices is 1 i.e. c = 1. This
% follows that p = c/(n-1)
% for n = 1000, p = 1/999 = 0.001
% for n = 10000, p = 1/9999 = 0.0001

%% Part b
%initial parameters (n, p)
n = 1000;
% p > 0.001
p = 0.002;

%create a symmetrical adjacency matrix
A = rand(n);
A = (A<p);
Au = triu(A);
A1 = Au';
Aout = Au + A1;
Aout = Aout - diag(diag(Aout));

figure;
graphnew = graph(Aout);
plot(graphnew);
[bins1, binsizes1] = conncomp(graphnew);

% p < 0.001
p = 0.0001;

%create a symmetrical adjacency matrix
A = rand(n);
A = (A<p);
Au = triu(A);
A1 = Au';
Aout = Au + A1;
Aout = Aout - diag(diag(Aout));

graphnew = graph(Aout);
figure;
plot(graphnew);
[bins2, binsizes2] = conncomp(graphnew);


% For the value where p < 0.001, there were much closer to 1000 groups,
% however when p > 0.001, the number of groups became much smaller,
% indicating groups were forming and there were fewer individual nodes.
% This indicates the appearance of a giant component, or a group which
% consists of a finite fraction of the nodes in a graph.

%% Part c
% For an Erdos-Reyni model of random graphs, when c > ln(n), the graph will
% almost surely be completely connected.
% For n = 1000, p = ln(1000)/1000 = 0.0069
% For n - 10000, p = ln(10000)/10000 = 0.00092

%% Part d
%initial parameters (n, p)
n = 1000;
% p > 0.0069
p = 0.008;

%create a symmetrical adjacency matrix
A = rand(n);
A = (A<p);
Au = triu(A);
A1 = Au';
Aout = Au + A1;
Aout = Aout - diag(diag(Aout));

graphnew = graph(Aout);
figure;
plot(graphnew);
[bins1, binsizes1] = conncomp(graphnew);

% p < 0.0069
p = 0.005;

%create a symmetrical adjacency matrix
A = rand(n);
A = (A<p);
Au = triu(A);
A1 = Au';
Aout = Au + A1;
Aout = Aout - diag(diag(Aout));

graphnew = graph(Aout);
figure;
plot(graphnew);
[bins2, binsizes2] = conncomp(graphnew);


% For the value where p < 0.0069, there was more than 1 group, indicating
% that the graph was not fully connected, however when p > 0.0069, the 
% number of groups became 1, indicating the presence of a single group of
% nodes in the network. This meant the network had become fully connected
% when p > 0.0069 for a network of 1000 nodes.

