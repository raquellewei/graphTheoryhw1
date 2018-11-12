%1
% takes in a filename, returns adjacency matrix 
function adj_matrix = Find_adj_matrix(filename) 
matrix_raw = dlmread(filename,'');
n = matrix_raw(1,1);
matrix_raw(1,:) = [];
adj_matrix = zeros(n);
for i = 1:length(matrix_raw(:,1))
    adj_matrix(matrix_raw(i,1),matrix_raw(i,2)) = 1;
    adj_matrix(matrix_raw(i,2),matrix_raw(i,1)) = 1;
end
end