function [Rankmtx] = matrix_tiedrank(M)
% a function to compute the tiedrank matrix given an input, unranked,
% matrix
%
% matrix should be of the format nxtxk, where n is the number of rois
% and k is the number of subjects and t can be another dimension for the
% number of rois (in the case of an adjacency representation of the
% network) or the time in the case of timeseries

if sum(sum(sum(isnan(M))) > 0)
    error('Error: the matrix input contains NaNs');
end

[n,t,k] = size(M);

Rankmtx = zeros(n,t,k);
    
for i=1:k
    A = M(:,:,i);
    Ranki = tiedrank(A(:));
    Rankmtx(:,:,i) = reshape(Ranki, n, t);
    
end