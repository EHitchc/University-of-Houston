clc; clear all; close all;

baylorData = load('Baylor93.mat');
georgetownData = load('Georgetown15.mat');
michiganData = load('Michigan23.mat');
pepperdineData = load('Pepperdine86.mat');
wesleyanData = load('Wesleyan43.mat');


baylorG = graph(baylorData.A);
baylorKu = degree(baylorG);
baylorAverKu = mean(baylorKu)
baylorVarKu = var(baylorKu);
baylorAverKv = baylorAverKu + baylorVarKu/baylorAverKu

georgetownG = graph(georgetownData.A);
georgetownKu = degree(georgetownG);
georgetownAverKu = mean(georgetownKu);
georgetownVarKu = var(georgetownKu);
georgetownAverKv = georgetownAverKu + georgetownVarKu/georgetownAverKu

michiganG = graph(michiganData.A);
michiganKu = degree(michiganG);
michiganAverKu = mean(michiganKu);
michiganVarKu = var(michiganKu);
michiganAverKv = michiganAverKu + michiganVarKu/michiganAverKu

pepperdineG = graph(pepperdineData.A);
pepperdineKu = degree(pepperdineG);
pepperdineAverKu = mean(pepperdineKu);
pepperdineVarKu = var(pepperdineKu);
pepperdineAverKv = pepperdineAverKu + pepperdineVarKu/baylorAverKu

wesleyanG = graph(wesleyanData.A);
wesleyanKu = degree(wesleyanG);
wesleyanAverKu = mean(wesleyanKu);
wesleyanVarKu = var(wesleyanKu);
wesleyanAverKv = wesleyanAverKu + wesleyanVarKu/wesleyanAverKu

x = [baylorAverKu georgetownAverKu michiganAverKu pepperdineAverKu wesleyanAverKu];
y = [baylorAverKv georgetownAverKv michiganAverKv pepperdineAverKv wesleyanAverKv];

scatter(x,y);
grid on;
title('Kv vs Ku for 5 Facebook Networks');
xlabel('Ku');
ylabel('Kv');

labels = ["Baylor", "Georgetown", "Michigan", "Pepperdine", "Wesleyan"];
dx = 0.4; dy = 0;
text(x +dx, y +dy, labels);

test = [labels; x; y]