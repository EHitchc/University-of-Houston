clc; clear all; close all;

baylorData = load('Baylor93.mat');
dartmouthData = load('Dartmouth6.mat');
georgetownData = load('Georgetown15.mat');
howardData = load('Howard90.mat');
michiganData = load('Michigan23.mat');
pepperdineData = load('Pepperdine86.mat');
riceData = load('Rice31.mat');
UVAData = load('UVA16.mat');
wesleyanData = load('Wesleyan43.mat');
yaleData = load('Yale4.mat');

%Graph data
baylorG = graph                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  (baylorData.A);
%Find largest cluster
baylorGCluster = conncomp(baylorG, 'OutputForm', 'cell');
%Turn into array for indexing
baylorlargestCluster = cell2mat(baylorGCluster(1));
%Calc size for average
baylorNumLargestCluster = length(baylorlargestCluster);
%Get Diameters inside cluster
baylorDiameter = distances(baylorG, baylorlargestCluster, baylorlargestCluster);
%Get Largest Diameter
baylorLargestDiameter = max(max(baylorDiameter));
%Calculate Average Geodesic Diameter
baylorAverageDiameter = sum(sum(baylorDiameter))/(baylorNumLargestCluster^2);

dartmouthG = graph(dartmouthData.A);
%Find largest cluster
dartmouthGCluster = conncomp(dartmouthG, 'OutputForm', 'cell');
%Turn into array for indexing
dartmouthlargestCluster = cell2mat(dartmouthGCluster(1));
%Calc size for average
dartmouthNumLargestCluster = length(dartmouthlargestCluster);
%Get Diameters inside cluster
dartmouthDiameter = distances(dartmouthG, dartmouthlargestCluster, dartmouthlargestCluster);
%Get Largest Diameter
dartmouthLargestDiameter = max(max(dartmouthDiameter));
%Calculate Average Geodesic Diameter
dartmouthAverageDiameter = sum(sum(dartmouthDiameter))/(dartmouthNumLargestCluster^2);

georgetownG = graph(georgetownData.A);
%Find largest cluster
georgetownGCluster = conncomp(georgetownG, 'OutputForm', 'cell');
%Turn into array for indexing
georgetownlargestCluster = cell2mat(georgetownGCluster(1));
%Calc size for average
georgetownNumLargestCluster = length(georgetownlargestCluster);
%Get Diameters inside cluster
georgetownDiameter = distances(georgetownG, georgetownlargestCluster, georgetownlargestCluster);
%Get Largest Diameter
georgetownLargestDiameter = max(max(georgetownDiameter));
%Calculate Average Geodesic Diameter
georgetownAverageDiameter = sum(sum(georgetownDiameter))/(georgetownNumLargestCluster^2);

howardG = graph(howardData.A);
%Find largest cluster
howardGCluster = conncomp(howardG, 'OutputForm', 'cell');
%Turn into array for indexing
howardlargestCluster = cell2mat(howardGCluster(1));
%Calc size for average
howardNumLargestCluster = length(howardlargestCluster);
%Get Diameters inside cluster
howardDiameter = distances(howardG, howardlargestCluster, howardlargestCluster);
%Get Largest Diameter
howardLargestDiameter = max(max(howardDiameter));
%Calculate Average Geodesic Diameter
howardAverageDiameter = sum(sum(howardDiameter))/(howardNumLargestCluster^2);

michiganG = graph(michiganData.A);
%Find largest cluster
michiganGCluster = conncomp(michiganG, 'OutputForm', 'cell');
%Turn into array for indexing
michiganlargestCluster = cell2mat(michiganGCluster(1));
%Calc size for average
michiganNumLargestCluster = length(michiganlargestCluster);
%Get Diameters inside cluster
michiganDiameter = distances(michiganG, michiganlargestCluster, michiganlargestCluster);
%Get Largest Diameter
michiganLargestDiameter = max(max(michiganDiameter));
%Calculate Average Geodesic Diameter
michiganAverageDiameter = sum(sum(michiganDiameter))/(michiganNumLargestCluster^2);

pepperdineG = graph(pepperdineData.A);
%Find largest cluster
pepperdineGCluster = conncomp(pepperdineG, 'OutputForm', 'cell');
%Turn into array for indexing
pepperdinelargestCluster = cell2mat(pepperdineGCluster(1));
%Calc size for average
pepperdineNumLargestCluster = length(pepperdinelargestCluster);
%Get Diameters inside cluster
pepperdineDiameter = distances(pepperdineG, pepperdinelargestCluster, pepperdinelargestCluster);
%Get Largest Diameter
pepperdineLargestDiameter = max(max(pepperdineDiameter));
%Calculate Average Geodesic Diameter
pepperdineAverageDiameter = sum(sum(pepperdineDiameter))/(pepperdineNumLargestCluster^2);

riceG = graph(riceData.A);
%Find largest cluster
riceGCluster = conncomp(riceG, 'OutputForm', 'cell');
%Turn into array for indexing
ricelargestCluster = cell2mat(riceGCluster(1));
%Calc size for average
riceNumLargestCluster = length(ricelargestCluster);
%Get Diameters inside cluster
riceDiameter = distances(riceG, ricelargestCluster, ricelargestCluster);
%Get Largest Diameter
riceLargestDiameter = max(max(riceDiameter));
%Calculate Average Geodesic Diameter
riceAverageDiameter = sum(sum(riceDiameter))/(riceNumLargestCluster^2);

UVAG = graph(UVAData.A);
%Find largest cluster
UVAGCluster = conncomp(UVAG, 'OutputForm', 'cell');
%Turn into array for indexing
UVAlargestCluster = cell2mat(UVAGCluster(1));
%Calc size for average
UVANumLargestCluster = length(UVAlargestCluster);
%Get Diameters inside cluster
UVADiameter = distances(UVAG, UVAlargestCluster, UVAlargestCluster);
%Get Largest Diameter
UVALargestDiameter = max(max(UVADiameter));
%Calculate Average Geodesic Diameter
UVAAverageDiameter = sum(sum(UVADiameter))/(UVANumLargestCluster^2);

wesleyanG = graph(wesleyanData.A);
%Find largest cluster
wesleyanGCluster = conncomp(wesleyanG, 'OutputForm', 'cell');
%Turn into array for indexing
wesleyanlargestCluster = cell2mat(wesleyanGCluster(1));
%Calc size for average
wesleyanNumLargestCluster = length(wesleyanlargestCluster);
%Get Diameters inside cluster
wesleyanDiameter = distances(wesleyanG, wesleyanlargestCluster, wesleyanlargestCluster);
%Get Largest Diameter
wesleyanLargestDiameter = max(max(wesleyanDiameter));
%Calculate Average Geodesic Diameter
wesleyanAverageDiameter = sum(sum(wesleyanDiameter))/(wesleyanNumLargestCluster^2);

yaleG = graph(yaleData.A);
%Find largest cluster
yaleGCluster = conncomp(yaleG, 'OutputForm', 'cell');
%Turn into array for indexing
yalelargestCluster = cell2mat(yaleGCluster(1));
%Calc size for average
yaleNumLargestCluster = length(yalelargestCluster);
%Get Diameters inside cluster
yaleDiameter = distances(yaleG, yalelargestCluster, yalelargestCluster);
%Get Largest Diameter
yaleLargestDiameter = max(max(yaleDiameter));
%Calculate Average Geodesic Diameter
yaleAverageDiameter = sum(sum(yaleDiameter))/(yaleNumLargestCluster^2);

%%
x = [baylorNumLargestCluster dartmouthNumLargestCluster georgetownNumLargestCluster howardNumLargestCluster michiganNumLargestCluster pepperdineNumLargestCluster riceNumLargestCluster UVANumLargestCluster wesleyanNumLargestCluster yaleNumLargestCluster];
y = [baylorLargestDiameter dartmouthLargestDiameter georgetownLargestDiameter howardLargestDiameter michiganLargestDiameter pepperdineLargestDiameter riceLargestDiameter UVALargestDiameter wesleyanLargestDiameter yaleLargestDiameter];

scatter(x,y);
grid on;
title('Largest Diameter vs Network Size for 10 Facebook Networks');
xlabel('Network Size');
ylabel('Largest Diameter');

labels = ["Baylor", "Dartmouth", "Georgetown", "Howard", "Michigan", "Pepperdine", "Rice", "UVA", "Wesleyan", "Yale"];
dx = 0.4; dy = 0;
text(x +dx, y +dy, labels);

test = [labels; x; y];
%%
x = [baylorNumLargestCluster dartmouthNumLargestCluster georgetownNumLargestCluster howardNumLargestCluster michiganNumLargestCluster pepperdineNumLargestCluster riceNumLargestCluster UVANumLargestCluster wesleyanNumLargestCluster yaleNumLargestCluster];
y = [baylorAverageDiameter dartmouthAverageDiameter georgetownAverageDiameter howardAverageDiameter michiganAverageDiameter pepperdineAverageDiameter riceAverageDiameter UVAAverageDiameter wesleyanAverageDiameter yaleAverageDiameter];

scatter(x,y);
grid on;
title('Largest Diameter vs Network Size for 10 Facebook Networks');
xlabel('Network Size');
ylabel('Largest Diameter');

labels = ["Baylor", "Dartmouth", "Georgetown", "Howard", "Michigan", "Pepperdine", "Rice", "UVA", "Wesleyan", "Yale"];
dx = 0.4; dy = 0;
text(x +dx, y +dy, labels);

test = [labels; x; y];