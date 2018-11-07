fid = fopen('example1.txt');
line = fgetl(fid);
n = line;
n = str2num(n);

edges_list = cell(1,n);
while feof(fid)==0
    line = fgetl(fid);
    e = split(line);
    if not (ismember(str2num(e{2}),edges_list{str2num(e{1})}))
        edges_list{str2num(e{1})}=[edges_list{str2num(e{1})},str2num(e{2})];
        edges_list{str2num(e{2})}=[edges_list{str2num(e{2})},str2num(e{1})];
    end
end
celldisp(edges_list);