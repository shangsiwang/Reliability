function smg = loadsgs(dirr)
%% Load files
cwd = pwd;
cd(dirr)
files = dir('*.mat');

c = 1;
for i = 1:length(files)
    temp = load(files(i).name);
    tgraph = log10(full(temp.graph));% log10
    if length(tgraph) < 70
        files(i).name
        continue;
    end
    tgraph = tgraph(1:70, 1:70);
    tgraph(isinf(tgraph))=0;
    %     tgraph=full(temp.graph);
    smg(:,:,c) = tgraph;
    c = c+1;
end
cd(cwd)
end