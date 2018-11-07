fid = fopen('example1.txt');
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
celldisp(edges_list);




black_node = [];
Q = [];
white_node = [];
for i = 1:size
    white_node = [white_node,i];
end
bfs_matrix = zeros(2,size);

index = 1;
while(true)
    pos = randi(length(white_node));
    start_n = white_node(pos);
    white_node(pos) = [];
    Q = [Q,start_n];%add root into Q
    
    while(~isempty(Q))
        n = Q(1);
        %index = 1;
        %initial root in the bfs matrix
        bfs_matrix(1,index) = start_n;
        bfs_matrix(2,index) = 0;
    
        %n = start_n;
    
        if ~isempty(edges_list{n})
            dump = 0;
            parents = n; %set parents of all adjacent nodes as n;
            for i = 1:length(edges_list{n})%find all adjacent nodes of n
            
                temp = edges_list{n}(i); %temp is a adjacent node of n

                if(ismember(temp,white_node))%temp has not been visited
                    white_node(find(white_node == temp)) = []; %remove a adjacent node from whilt_node set(visit temp)
                    Q = [Q,temp]; %add temp into Q
                    bfs_matrix(1,index+i-dump) = temp;%add temp into the bfs_matrix
                    bfs_matrix(2,index+i-dump) = parents;%add the parents of temp into the bfs_matrix
                else
                    dump = dump + 1;
                    continue;
                end
            end
            index = index + length(edges_list) - dump;
            
            black_node = [black_node,Q(1)];%add n into black_node set
            Q(1) = [];%remove n from Q
        else
            black_node = [black_node,Q(1)];%add n into black_node set
            Q(1) = [];%remove n from Q
        end
    end
    if(isempty(white_node))
        break;
    end
end
disp(bfs_matrix)
