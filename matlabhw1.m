%1
% takes in a filename, returns adjacency matrix 
filename = {'hwcheck1.txt'};
function adj_matrix = Find_adj_matrix(filename) 
fid = fopen('~/Desktop/graphtheory/test_files/simple.txt','r')
n = str2num(fgetl(fid))
adj_matrix = zeros(n);

while feof(fid) == 0
    line = fgetl(fid);
    line = split(line);
    adj_matrix(str2num(line{1}),str2num(line{2})) = 1;
    adj_matrix(str2num(line{2}),str2num(line{1})) = 1;
end



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
