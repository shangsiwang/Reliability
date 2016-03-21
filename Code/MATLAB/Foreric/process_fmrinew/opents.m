function ts = opents(files, numsubs, fileval)


% a function to open a timeseries into a usable format
% Inputs:
%   files: a struct containing filenames in the file(i).name category
%   numsubs: the number of subjects
%   fileval: the batch of subjects in the file being considered
%       this parameter enables process_dataset to operate on many rois at
%       once
% Outputs
%   ts: the usable matrix containing the timeseries of the subjects

c = 1;
for i = 1:numsubs
    temp = files(i + numsubs * (fileval-1)).name;
    mtx = load(temp); % log10
    tgraph = mtx.roi_data;
    tgraph(isinf(tgraph))=0;
    %     tgraph=full(temp.graph);
    ts(:,:,c) = tgraph;
    c = c+1;
end