dataset='KKI';
load('KKIfullresults.mat')
lenstart=length(dataset);
newname=cell(64, 6);
%col 1 is the processing method (ANTs or FNIRT), 2 is ff or not, 3 is
%scrubbing or not, 4 is GSR or no GSR, 5 is the mask
for i = 1:length(strname)
    char1=strname{i,1}(lenstart+1);
    char2=strname{i,1}(lenstart+2);
    char3=strname{i,1}(lenstart+3);
    newname{i,1} = dataset;
    if (char1 == '1' || char1 == '2' || char1 == '3' || char1 == '4')
        newname{i,2} = 'ANTs';
    else 
        newname{i,2} = 'FNIRT';
    end
    if (char1 == '2' || char1 == '3' || char1 == '6' || char1 == '7')
        newname{i,3} = 'ff';
    else
        newname{i,3} = 'nff';
    end
    if (char1 == '3' || char1 == '4' || char1 == '7' || char1 == '8')
        newname{i,4} = 's';
    else
        newname{i,4} = 'ns';
    end
    if (char2 == '1')
        newname{i,5} = 'g';
    else 
        newname{i,5} = 'ng';
    end
    
    if (char3 == '1')
        newname{i,6} = 'aal';
    elseif (char3 == '2')
        newname{i,6} = 'CC200';
    elseif (char3 == '3')
        newname{i,6} = 'ho';
    elseif (char3 == '4')
        newname{i,6} = 'desik';
    end
end