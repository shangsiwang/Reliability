% The function computes complete graphs based on time series
% The input should be a k*T*n or k*T matrix where
% k is the number of regions of interest
% T is the length of time series
% n is the number subject
% The output is a k*k*n complete matrix which records the
% absolute correlations between rois
function [graphs]=build_graph(ts)

% check whehter input has nan
if (sum(sum(sum(isnan(ts))))>0)
    error('Error: Input time series has NaNs.')
end

[k,~,n]=size(ts);
graphs=zeros(k,k,n);

% compute absolute correlations between rois
for i=1:n
    graphi=abs(corrcoef(ts(:,:,i)'));
    graphi(logical(eye(k)))=0;
    graphs(:,:,i)=graphi;
end

% set nan to 0
graphs(isnan(graphs))=0;

end
