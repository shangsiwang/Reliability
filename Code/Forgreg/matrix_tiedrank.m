function [Rankmtx] = matrix_tiedrank(M)
% a function to compute the tiedrank matrix given an input, unranked,
% matrix
%
% matrix should be of the format nxnxk, where n is the number of rois
% and k is the number of subjects

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