function edge_list = Find_edge_list(filename)
fid = fopen(filename,'r');
line = fgetl(fid);
n = line;
n = str2num(n);

edge_list = cell(1,n);
while feof(fid)==0
    line = fgetl(fid);
    e = split(line);
    if not (ismember(str2num(e{2}),edge_list{str2num(e{1})}))
        edge_list{str2num(e{1})}=[edge_list{str2num(e{1})},str2num(e{2})];
        edge_list{str2num(e{2})}=[edge_list{str2num(e{2})},str2num(e{1})];
    end
end
end