function [graphs, c] = opents_nbin(files, numscans, fileval, numslices)


% a function to open a timeseries into a usable format
% Inputs:
%   files: a struct containing filenames in the file(i).name category
%   numsubs: the number of subjects
%   fileval: the batch of subjects in the file being considered
%       this parameter enables process_dataset to operate on many rois at
%       once
%   numslices: the number of time slices that each subject initially had
%   data for
% Outputs
%   ts: the usable matrix containing the timeseries of the subjects

numsubs=numscans/2;

if (round(numsubs) ~= numsubs)
    error('The number of subjects is somehow inconsistent.\n Error in open_nbin');
end
c=0;
for i = 1:2:numscans
    temp1 = files(i + numscans * (fileval-1)).name;
    temp2 = files(i + numscans * (fileval-1) + 1).name;
    
    
    mtx1 = load(temp1); % log10
    mtx2=load(temp2);
    tgraph1 = mtx1.roi_data;
    tgraph2 = mtx2.roi_data;
    
    if (size(tgraph1,2) >= (numslices/4) && size(tgraph2,2) >= (numslices/4))
        tgraph1(isinf(tgraph1))=0;
        tgraph2(isinf(tgraph2))=0;
        %     tgraph=full(temp.graph);
        graphi1=abs(corrcoef(tgraph1(:,:)'));
        graphi2=abs(corrcoef(tgraph2(:,:)'));
        [k,~]=size(tgraph1);
        [k,~]=size(tgraph2);
        graphi1(logical(eye(k)))=0;
        graphi2(logical(eye(k)))=0;
        graphs(:,:,c+1)=graphi1;
        graphs(:,:,c+2) = graphi2;
        c = c+2;
    end
end

graphs(isnan(graphs))=0;
end
