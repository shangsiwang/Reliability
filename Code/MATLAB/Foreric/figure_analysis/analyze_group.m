files=dir('roi*.mat');
numsubs=42;
numatlases=length(files)/numsubs;
d=25;

% mnrfullrank=zeros(numatlases,d);
% threshfullrank=zeros(numatlases,d);
% mnrrank=zeros(1,numatlases);
% threshrank=zeros(1,numatlases);
% rois=zeros(1,numatlases);
% D = zeros(numsubs, numsubs, numatlases);

[mnrfull,threshfull,mnr,thresh,rois, D] = process_dataset(files, numsubs, @build_graph, 0);

save('outputs_ccatlascpac.mat');
