%demo script which shows how to use the find_nbinstar.m script for finding
%optimal partitioning of ranked graphs.


load('demo_nbinstar.mat'); %email gkiar@jhu.edu for file
S = size(smg, 3);
ids = ceil(0.5:0.5:(S/2)); %assumes neighbour is partner

smg_ranks = matrix_tiedrank(smg);

spacing = 'lin';
N = 50;
normalize = true;

[nbinstar, mnrs_dist, bins, rdf, bin_smgs] =  ...
            find_nbinstar(smg_ranks, ids, normalize, N, spacing);

figure (1);
subplot(121);
plot(2:N, mnrs_dist, nbinstar, mnrs_dist(nbinstar-1), 'r*');
title(strcat('Distribution of MNR based on partitioning. nbin*=', num2str(nbinstar)));
xlabel('Number of partitions'); ylabel('MNR');

subplot(122);
hist(rdf);
title('Reliability distribution function of optimally paritioned graphs');
xlabel('Rank'); ylabel('Number of occurences');