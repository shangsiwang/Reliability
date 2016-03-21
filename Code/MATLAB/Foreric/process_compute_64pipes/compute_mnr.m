% The function computes mnr for data 
% D should be an n*n matrix recording pairwise distance
% ID should be a vector of length n representing subject id
% of each row of D 
% The output are MNR of data set, standard error of MNR estimate
% and all MNRs for each pair of observations.
% Usage:
% MNR=compute_mnr(D,ID)
%[MNR, stdMNR] = compute_mnr(D,ID)
% [MNR, stdMNR, MNRs] = compute_mnr(D,ID)
function [ MNR, stdMNR, MNRs ] = compute_mnr(D,ID)
n=length(ID);
ranks=0;
rankij=[];
count=0;
if nargout>1
    MNRs=[];
end
for i=1:n    
    ind=find(ID==ID(i));
    s=length(ind);
    for j=ind
    di=D(i,:);
    d=D(i,j);
    di(ind)=Inf;
    if i~=j
        r=1-(sum(di<d) + 0.5*sum(di==d))/(n-s);
        ranks=r+ranks;
        count=count+1;
        rankij(count)=r;
        if nargout>1
            MNRs=[MNRs r];
        end
    end
    end   
end
MNR=ranks/count;
if nargout>1
    stdMNR=sqrt(var(rankij)/count);
end

end


