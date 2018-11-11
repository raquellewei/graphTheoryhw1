fid = fopen('example1.txt');
line = fgetl(fid);
%size = line;
size = str2num(line);

edges_list = cell(1,size);
while feof(fid)==0
    line = fgetl(fid);
    e = split(line);
    
    %these two lines are calculating the adjacent matrix
    adj_matrix(str2num(e{1}),str2num(e{2})) = 1
    adj_matrix(str2num(e{2}),str2num(e{1})) = 1;
    
    % this if statement is calculating the edges list
    if not (ismember(str2num(e{2}),edges_list{str2num(e{1})}))
        edges_list{str2num(e{1})}=[edges_list{str2num(e{1})},str2num(e{2})];
        edges_list{str2num(e{2})}=[edges_list{str2num(e{2})},str2num(e{1})];
    end
end
%celldisp(edges_list);


%%
%initial three lists
black_node = [];
Q = [];
white_node = [];

for i = 1:size
    white_node = [white_node,i];
end
bfs_matrix = zeros(2,size); % to check if the edge list is correct

%%
index = 0;
while(true) %searching on each spanning tree
    pos = randi(length(white_node)); 
    start_n = white_node(pos); %initial root
    white_node(find(white_node == start_n)) = []; %delete root from the white-node list
    %disp(index)
    Q = [Q,start_n];%add root into Q
    index = index + 1;% This step is very important! Add node in the next empty row in the matrix!
    bfs_matrix(1,index) = start_n;
    bfs_matrix(2,index) = 0;
    parents = start_n;
    while(~isempty(Q)) % if the current spanning tree is still in searching 
        n = Q(1);%Q is last-in-first-out
        %disp(n);
        %disp(index);
        %index = 1;
        %add root in the bfs matrix
        
        if ~isempty(edges_list{n}) %it has adjacent node
            dump = 0;
            parents = n; %set parents of all adjacent nodes as n;
            for i = 1:length(edges_list{n})%find all adjacent nodes of n
            
                temp = edges_list{n}(i); %temp is a adjacent node of n

                if(ismember(temp,white_node))%temp has not been visited
                    white_node(find(white_node == temp)) = []; %remove a adjacent node from whilt-node list(visit temp)
                    Q = [Q,temp]; %add temp into Q
                    bfs_matrix(1,index+i-dump) = temp;%add temp into the bfs_matrix
                    bfs_matrix(2,index+i-dump) = parents;%add the parents of temp into the bfs_matrix
                else
                    dump = dump + 1;
                    continue;
                end
            end
            index = index + length(edges_list{n}) - dump;
            
            black_node = [black_node,Q(1)];%add n into black_node set
            Q(1) = [];%remove n from Q
            
        else % it has no adjacent node
            black_node = [black_node,Q(1)];%add n into black_node set
            Q(1) = [];%remove n from Q
        end
    end
    if(isempty(white_node) && isempty(Q))
        %disp(n) 
        break; %All spanning tress are found
    end
end
disp(bfs_matrix);


%%
color1 = [bfs_matrix(1,1)]; % initial set of nodes with color 1 AND add the first root in
color2 = []; %initial set of nodes with color 2

for i = 2:size %color all nodes in the graph
    if ismember(bfs_matrix(2,i),color1)
        color2 = [color2, bfs_matrix(1,i)];
    else
        color1 = [color1, bfs_matrix(1,i)];
    end
end

%%
flag = 0;


for i = 1:length(color1)% determine if two adjacent nodes' colors are identical(both color 1)
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
for i = 1:length(color2)% determine if two adjacent nodes' colors are identical(both color 2)
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
