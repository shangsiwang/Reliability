function [graphs] = ts2pcorr(ts)
% a function for returning the sample linear partial correlation
% coefficients between pairs of variables in Timeseries
% Inputs:
%   Timeseries: matrix of the form nxtxk, where n is the number of rois, t
%   is the number of timesteps, and k is the number of subjects
% Outputs: 
% smg:
%   small graph of the partial correlation of the columns in Timeseries
%   of the form nxnxk, where n is the number of rois and k is the number of
%   subjects


if (sum(sum(sum(isnan(ts))))>0)
    error('Error: Input time series has NaNs.')
end

[n,t,k] = size(ts);
graphs=zeros(n,n,k);

for i=1:k
     graphi = pcorrsing(ts(:,:,i)');
%     graphi(logical(eye(k)))=0;
    graphs(:,:,i) = graphi;
end

%set NaNs to 0

graphs(isnan(graphs)) = 0;
end