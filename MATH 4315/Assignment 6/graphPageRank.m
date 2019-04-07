function [] = graphPageRank(G, names, pageRank)
%graphPageRank 
%   plots graph according to requirements as in part b)

nodeID = 1:size(G.Nodes, 1);
p = plot(G, 'nodeColor', 'r');

nodes = linspace(min(pageRank), max(pageRank), size(G.Nodes, 1));
bins = discretize(pageRank, nodes);

labelnode(p, nodeID, names);
p.MarkerSize = bins;
set(gcf, 'Position', [400, 200, 800, 600]);

end

