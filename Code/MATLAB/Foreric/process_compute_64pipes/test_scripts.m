clear all

A(:,:,1) = [2 5;3 1; 7 5];
A(:,:,2) = [2 4;4 3; 5 9];

%%testing the tiedrank computation
B(:,:,:) = matrix_tiedrank(A);

assert(all(all(B(:,:,1)==[2 4.5;3 1;6 4.5])));
assert(all(all(B(:,:,2)==[1 3.5;3.5 2;5 6])));

% all tests are compared against values computed manually to ensure
% accuracy

%%testing the partial correlation computation
pcorrtest = ts2pcorr(A);
assert(all(all(int64(pcorrtest(:,:,1)) == [-1 1 1; 1 -1 -1; 1 -1 -1])));
assert(all(all(int64(pcorrtest(:,:,2)) == [-1 1 -1; 1 -1 1; -1 1 -1])));

%%testing the covariance computation
covtest = ts2cov(A);
assert(all(all(covtest(:,:,1) == [4.5 -3 -3; -3 2 2; -3 2 2])));
assert(all(all(covtest(:,:,2) == [2 -1 4; -1 .5 -2; 4 -2 8])));

% can't really test this one because I don't know how to compute a pseudo
% inverse manually...
%%testing the inverse covariance computation
invcovtest = ts2invcov(A);
