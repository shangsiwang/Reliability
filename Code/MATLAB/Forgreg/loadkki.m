function smg = loadkki(dirr)
%% Load files
cwd = pwd;
cd(dirr)
files = dir('*.mat');
temp = importdata('kki42_subjectinformation.csv');

for i = 2:length(temp)
    reorderIdx(i-1) = str2num(temp{i}(end-1:end));
end

c = 1;
for i = reorderIdx
    temp = load(files(i).name);
    tgraph = log10(full(temp.graph));% log10
    tgraph = tgraph(1:70, 1:70);
    tgraph(isinf(tgraph))=0;
    %     tgraph=full(temp.graph);
    smg(:,:,c) = tgraph;
    
    c = c+1;
end
cd(cwd)
end