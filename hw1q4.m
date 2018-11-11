start_pts = find(bfs_matrix(2,:) == 0)
comp_max = 0;
for i = 1:length(start_pt)-1
    comp = start_pts(i+1)-start_pts(i)
    if comp > comp_max
        comp_max = comp
        begin = i + 1;
    end
end

component = [];
 for i = begin:begin+comp_max-1
    component = [component, bfs_matrix(1,i)];
    component = [component, bfs_matrix(2,i)];
    component = unique(component);
 end
 