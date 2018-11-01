%1
% takes in a filename, returns adjacency matrix 
filename = {'hwcheck1.txt'};
function adj_matrix = Find_adj_matrix(filename) 
    



%2
% returns edge-list of the graph
function Find_edge_list(filename)


%3
%returns BFS spanning forest
Find_BFS_forest()

%4
%returns the list of nodes in the largest connected component.
%tie-breaker: lowest index node wins
Find_largest_component()

%5
%decide if a graph is bipartite
Is_bipartite()