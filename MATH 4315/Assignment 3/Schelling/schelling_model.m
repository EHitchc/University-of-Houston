%% simple segregation simulation
sch = Schelling(50, 50, 0.4, 0.4, 1000, 'schelling_simulation');
sch = sch.populate();
sch.update();

%load stored schelling matrix
data = load('final_matrix.mat');
%use altered functions from schelling.m to calculate similarity and
%difference for each cell
[sim, diff] = similarity(data.final, 50, 50);
%calculate average number of similar cells surrounding each cell
simAv = mean(mean(sim));
%calculate similarity_ratio of matrix for comparison with similarity threshold
similarityRatio = (sim)./(sim+diff);
similarityRatioAv = mean(mean(similarityRatio));