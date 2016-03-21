function tsret = opents_mult(files, numsubs,numstudies, fileval)


% a function to open a timeseries into a usable format
% Inputs:
%   files: a struct containing filenames in the file(i).name category
%   numsubs: the number of subjects
%   fileval: the batch of subjects in the file being considered
%       this parameter enables process_dataset to operate on many rois at
%       once
%   numstudies: the number of studies being looked at
% Outputs
%   ts: the usable matrix containing the timeseries of the subjects
numsubstart = 1;
tsret=[];
for studiter = 1:numstudies
    clear ts;
    c = 0;
    while ((c + numsubstart) <= numsubs) && (studiter == files(numsubstart+c).studyval)
            c = c+1;
    end
    ts = opents(files(numsubstart:numsubstart+c-1),c,fileval);
    numsubstart=c+1;    
    tsret{studiter} = num2cell(ts);
end
