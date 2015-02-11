%The function computes mnr for data
%D should be an n*n matrix recording pairwise distance
%ID should be a vector of length n representing subject id
%of each row of D
function [ MNR ] = compute_mnr(D,ID)
n=length(ID);
ranks=0;
count=0;
for i=1:n    
    ind=find(ID==ID(i));
    s=length(ind);
    for j=ind
    di=D(i,:);
    d=D(i,j);
    di(ind)=Inf;
    if i~=j
        ranks=(sum(di<d) + 0.5*sum(di==d))/(n-s)+ranks;
        count=count+1;
    end
    end   
end
MNR=ranks/count;
end


