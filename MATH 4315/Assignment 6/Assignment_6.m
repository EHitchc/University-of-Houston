%% Initialize
clc; clear; close all;

%% 3a)
Gdata = load('prcentrality.mat');
G = digraph(Gdata.A);

fprintf('PageRank centralities no longer change after 8 iterations\n');
%PageRank no longer changes past 8 iterations
pageRank = centrality(G, 'pagerank', 'MaxIterations', 8);
D = [Gdata.names pageRank];
fprintf('%15s:\t%.4f\n', D');

%% 3b)
graphPageRank(G, Gdata.names, pageRank);
title('Network of Trades Between 24 Nations in 1992, 8 PageRank Iterations');

%% 3c)
[B, I] = maxk(pageRank, 3);
fprintf('\n\nCountries with highest PageRank scores: \n')
fprintf('%s\n', Gdata.names(I));

%% 3d)
close all;
% FollowProbability = 0.3
pageRankFP1 = centrality(G, 'pagerank', 'FollowProbability', 0.3);
figure;
graphPageRank(G, Gdata.names, pageRankFP1);
title('Network of Trades Between 24 Nations in 1992, 0.3 Follow Probability');

% FollowProbability = 0.5
pageRankFP2 = centrality(G, 'pagerank', 'FollowProbability', 0.5);
figure;
graphPageRank(G, Gdata.names, pageRankFP2);
title('Network of Trades Between 24 Nations in 1992, 0.5 Follow Probability');

% FollowProbability = 0.7
pageRankFP3 = centrality(G, 'pagerank', 'FollowProbability', 0.7);
figure;
graphPageRank(G, Gdata.names, pageRankFP3);
title('Network of Trades Between 24 Nations in 1992, 0.7 Follow Probability');

%% 3e)
pageRankComp = [pageRank pageRankFP1 pageRankFP2 pageRankFP3];
fprintf('%20s\t%20s\t%20s\t%20s\n', 'MaxIterations = 8', 'FollowProbability = 0.3', 'FollowProbability = 0.5', 'FollowProbability = 0.7');
fprintf('%20.5f\t%20.5f\t%20.5f\t%20.5f\n', pageRankComp');

explanation = ["Graphically, there is no drastic change between the " ;
    "graph plots for each of the different PageRanks calculated. " ;
    "For the Nations with low out-degrees but high in-degrees, the " ;
    "PageRank for FollowProbability begins high but rapidly decreases " ;
    "i.e. Liberia, Honduras, Ecuador. In contrast, the very highly " ;
    "connected components (United States, United Kingdom) have low " ;
    "initial PageRanks but rapidly increase. Lastly, as the " ;
    "FollowProbability value increases, the pageRank approaches that " ;
    "of the pageRank with 8 iterations. The values are the same when " ;
    "FollowProbability = 0.85." ];
fprintf('%s\n', explanation);