matrix = dlmread('~/Desktop/graphtheory/test_files/hwcheck2.txt','');
n = matrix(1,1);
matrix(1,:) = [];
adj_matrix = zeros(n);
for i = 1:length(matrix(:,1))
    adj_matrix(matrix(i,1),matrix(i,2)) = 1;
    adj_matrix(matrix(i,2),matrix(i,1)) = 1;
end

color1 = [];
color2 = [];

temp = triu(adj_matrix,1);
for i = 1:n
    for j = 1:n
        if temp(i,j) == 1
            if ~ismember(i, color1) && ~ismember(i, color2)
                color1 = [color1, i];
                color2 = [color2, j];
            elseif ismember(i, color2)
                color1 = [color1, j];
            else
                color2 = [color2, j]
            end
        end
    end
end


if length(color1) + length(color2) == n
    disp("is bipartite");
else
    disp("is not bipartite");
end
