function component = Find_largest_component(filename)
fid = fopen(filename);
line = fgetl(fid);
%size = line;
size = str2num(line);

edges_list = cell(1,size);
while feof(fid)==0
    line = fgetl(fid);
    e = split(line);
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
    %start_n = white_node(1);
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
%disp(bfs_matrix)
%%



start_pts = find(bfs_matrix(2,:) == 0);
comp_max = 0;
%disp(start_pts);
L_left = 0;

index = 1;
while(index <= length(start_pts)) % find the size of the largest component
    if index < length(start_pts)
        left = start_pts(index);
        right = start_pts(index+1);
    else
        left = start_pts(index);
        right = size+1;
    end
    comp = right - left;
    if comp > comp_max
        comp_max = comp;
        L_left = left;
    end
    index = index+1;
end
%disp(L_left);

component = [];
for i = (L_left:L_left+comp_max-1) % L_left is the index of the root of the largest component in the bfs_matrix
   component = [component, bfs_matrix(1,i)];
end

 disp(component);
end
