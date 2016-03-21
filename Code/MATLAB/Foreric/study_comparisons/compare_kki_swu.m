% reads in by the number of studies being compared
% so that you can compare many at once
clear all
close all
substrings = {'roi_cc950*.mat','timeseries*.mat'};
files=[];
numstudies=length(substrings);
for i = 1:numstudies
    filetmp = dir((substrings{i}));
    filetmp().studyval=[];
    for subnum = 1:length(filetmp)
        filetmp(subnum).studyval = i;
    end
    files = [files; filetmp];
end
numsubs=length(files);
[mnrfull,threshfull,mnr,thresh,rois, D] = process_mult_studies(files, numsubs,...
    numstudies, @build_graph, 1);

save('outputs_compare_kki_swu.mat');