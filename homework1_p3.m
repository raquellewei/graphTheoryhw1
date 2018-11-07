
files = fopen('hwcheck1.txt','rt');
whole = fscanf(files,'%f'); 
%input the dimention of the matrix
n = whole(1);
index = 2;
%Create an empty edges list
edges_list = cell(1,n);

while(true)
    edges_list{whole(index)}=[edges_list{whole(index)},whole(index+1)];
    edges_list{whole(index+1)}=[edges_list{whole(index+1)},whole(index)];
    index = index + 2;
    if(length(whole)<=index)
        break;
    end
end
all_nodes = [];
for i = 2:length(whole)
    all_nodes = [all_nodes,whole(i)];
end

%initial the bfs searching matrix and the root, flag the root.
bfs_matrix = zeros(2,n);
Q = [];
start_n = 1;
flag = 0;
first_row = 1;
bfs_matrix(1,first_row) = start_n;
bfs_matrix(2,first_row) = flag;
Q = [Q,start_n];

n = start_n;
while(true)
    %flag root and put flagged roots in Q
    if(~edges_list{n})
        for i = 1:length(edges_list{n})
            temp = edges_list{n}(i);
            bfs_matrix(1,first_row+i) = temp;
            bfs_matrix(2,first_row+i) = flag+1;
            
            Q = [Q,temp];
        end
    else%current node has no adjacent node
        
    end
    
    %remove node out of Q
    Q(1) = [];
    
    
    flag = flag + 1;
    first_row = first_row + length(edges_list{n});
    
    n = Q(1);
end
