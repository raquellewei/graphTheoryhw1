function isbipartite = Is_bipartite(filename)

adj_matrix = Find_adj_matrix(filename);
n = length(adj_matrix(1,:));
bfs_matrix = Find_BFS_forest(filename);

color1 = [bfs_matrix(1,1)];
color2 = [];

for i = 2:n
    if ismember(bfs_matrix(2,i),color1)
        color2 = [color2, bfs_matrix(1,i)];
    else
        color1 = [color1, bfs_matrix(1,i)];
    end
end
   
flag = 0;

for i = 1:length(color1)
    for j = 1:length(color1)
        if adj_matrix(color1(i),color1(j)) == 1
            flag = 1;
            break;
        end
    end
    if flag == 1
        break;
    end
end
for i = 1:length(color2)
    for j = 1:length(color2)
        if adj_matrix(color2(i),color2(j)) == 1
            flag = 1;
            break;
        end
    end
    if flag == 1
        break;
    end

end

if flag == 1
    disp("not bipartite");
else
    disp("bipartite");
end
end