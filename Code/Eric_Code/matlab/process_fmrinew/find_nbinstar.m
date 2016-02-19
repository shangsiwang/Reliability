function [nbinstar, mnr, bins, rdf, bin_graph] = find_nbinstar(graphs, ids, normalize, k, spacing)
%Takes rank-passed graphs, and computes the optimal number of partitions to
%group the data in as defined by maximizing the MNR.
%Inputs:
%       graphs:     the MxMxS set of matrices (M is regions, S is subjects)
%       ids:        the 1xS vector of ids corresponding to the graphs
%       normalize:  {optional} to normalize or not to normalize graphs.
%       Default = true
%       k:          {optional} the maximum number of bins to test. Default
%       = 100
%       spacing:    {optional} the spacing of bins, options are: {'log',
%       'linear'}. Default = 'linear'
%Outputs:
%       nbinstar:   the optimal number of bins.
%       mnr:        the distribution of mnr for different bins
%       bins:       the bin lower bounds 
%       rdf:        the reliability distribution function graphs
%       thresholded at nbinstar
%       bin_graphs: the nbinstar partitioned graphs
%
%Usage example:
%       M = 40; S = 16; %50 regions, 16 subjects
%       graphs = rand([M, M, S]); %create random graphs
%       ids = ceil(0.5:0.5:S) %assign ids
%       [nbinstar, mnr, bins, rdf, bin_graphs] = find_nbinstar(graphs, ids,
%       true, 50, 'log')

if nargin < 2
    error('Too few args. Usage: [nbinstar, rdf, part_graphs] ' + ...
        '= find_nbinstar(graphs, ids, {normalize} ,{N}, {spacing})');
elseif nargin == 2
    k = 100;
    spacing = 'lin';
    normalize = true;
elseif nargin < 4
    k = 100;
    spacing = 'lin';
elseif nargin < 5
    spacing = 'lin';
end

if normalize
    %normalize graphs
    for i=1:size(graphs,3)
        graph_norm(:,:,i) = (graphs(:,:,i) - min2(graphs(:,:,i)))/ ...
            (max2(graphs(:,:,i)) - min2(graphs(:,:,i)));
    end
end
graphs = graph_norm;
maxval=size(graphs, 2)^2;

king = 0;
for i=linspace(2, maxval, k)
    if strcmp(spacing, 'log')
        bs = logspace(1/i, 1-1/i, i-1)/10;
    elseif strcmp(spacing, 'lin')
        bs = 1/i:1/i:(1-1/i);
    else
        error('Unknown spacing type. Options: {default=lin, log}');
    end
    tempg = zeros(size(graphs));

    for j=1:length(bs)
        tempg = tempg + (graphs > bs(j));
    end
    
    tempd = graph_todist(double(tempg));
    [mnr(i-1), ~, temp_rdf] = compute_mnr(tempd, ids);
    if mnr(i-1) > king
        king = mnr(i-1);
        rdf = temp_rdf;
        nbinstar = i;
        bins = bs;
        bin_graph = tempg;
    end
end

end