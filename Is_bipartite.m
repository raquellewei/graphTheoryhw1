function isbipartite = Is_bipartite(filename)

adj_matrix = Find_adj_matrix(filename);
n = length(adj_matrix(1,:));
bfs_matrix = Find_BFS_forest(filename);
%%
%initial two colors and add the first root into the color 1
color1 = [bfs_matrix(1,1)];
color2 = [];
%%
%color all nodes in two colors

for i = 2:n
    if ismember(bfs_matrix(2,i),color1)
        color2 = [color2, bfs_matrix(1,i)];
    else
        color1 = [color1, bfs_matrix(1,i)];
    end
end

%% 
% to find out if there is odd cycle
flag = 0;
% Variables mark1 and mark2 are going to be used later to store a pair of
% adjacent nodes with same color
mark1 = 0; 
mark2 = 0; 
boo2 = true; % explain it later

for i = 1:length(color1) % To find out if two adjacent nodes have the same color(color1)
    for j = 1:length(color1)
        %The following if statement is to find out and mark down one pair of
        %adjacent nodes with same color(color1). It won't be executed when 
        %all node with color1 are not adjacent.
        if adj_matrix(color1(i),color1(j)) == 1
            flag = 1; % Means this graph is not bipartite
            mark1 = color1(i); 
            mark2 = color1(j);
            break;
        end
    end
    if flag == 1
        break;
    end
end
for i = 1:length(color2) % To find out if two adjacent nodes have the same color(color2)
    for j = 1:length(color2)
        if adj_matrix(color2(i),color2(j)) == 1
            % the following if statement explains that we didn't find two nodes  
            % with same color(color1), then there shoukd be two nodes with same
            % color(color2)
            if(mark1 == 0 & mark2 == 0)
                flag = 1; % Means this graph is not bipartite
                mark1 = color2(i); 
                mark2 = color2(j);
                break;
            end
        end
    end
    if flag == 1
        break;
    end
end
%disp(color1)
%disp(color2)

%%
if flag == 1
    disp("not bipartite");
    % use the pair of nodes we found before and trace back to their
    % ancester(i.e. the common root)
    odd_seq = [];
    array1 = []; %To store the trace-back sequence from mark1 to the root
    array2 = []; %Slight different to array1. To store the trace-back sequence from mark2 to the first common ancester of mark1 and mark2 
    
    %disp(mark1);
    %disp(mark2);
    
    array1 = [array1,mark1];
    array2 = [array2,mark2];

    index1 = find(bfs_matrix(1,:) == mark1);
    index2 = find(bfs_matrix(1,:) == mark2);
    
    while ~(bfs_matrix(2,index1) == 0) % trace back from mark1 node to the root of its components
        mark1 = bfs_matrix(2,index1);
        array1 = [array1,mark1];
        index1 = find(bfs_matrix(1,:) == mark1);
    end
    if ismember(bfs_matrix(2,index2),array1) % We find the commom ancester of mark1 and mark2
        dump_index = find(array1 == bfs_matrix(2,index2));
    end
    while ~(ismember(bfs_matrix(2,index2),array1))
        mark2 = bfs_matrix(2,index2);
        array2 = [array2,mark2];
        index2 = find(bfs_matrix(1,:) == mark2);
        dump_index = find(array1 == bfs_matrix(2,index2));
    end
    for i = (1:length(array1)-dump_index) % To delete ancesters of the first common ancester of mark1 and mark2 from array1, since they are not in the cycle.
        array1(end) = [];
    end
    odd_seq = [array1,fliplr(array2)]; % To combine two arrays into a new array, which represents the sequences of nodes in the odd cycle.
    isbipartite = odd_seq;

else
    disp("bipartite");
    bipart_array = zeros(1,n);
    for i = 1:length(bipart_array)
       if(ismember(i,color1)) % To store color1 nodes as 0
           bipart_array(i)  = 0;
       else
           bipart_array(i)  = 1; % To store color2 nodes as 1
       end
    end
    isbipartite = bipart_array;
end
end
