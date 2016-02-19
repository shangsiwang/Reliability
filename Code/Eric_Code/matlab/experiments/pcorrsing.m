function [Pcorrmtx] = pcorrsing(inmtx)

% A function to compute the partial correlation given a singular input
%
% Inputs:
%   A: an input correlation matrix of the format nxn
% Outputs:
%   the matrix of partial correlations
%

n = size(inmtx, 2);

%Corrmtx = corrcoef(inmtx);
invCorr = pinv(inmtx);
Pcorrmtx = zeros(n);
for i = 1:n
    for j = 1:n
        Pcorrmtx(i,j)=-invCorr(i,j)/(sqrt(invCorr(i,i)*invCorr(j,j)));
    end
end

end
