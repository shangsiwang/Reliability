% Script to demonstrate how to use those functions
TimeSeries=randn(50,180,100); % roi*T*nsubect

% Convert Time series to weighted graphs
wgraphs=build_graph(TimeSeries);

% Threshold at 0.1
graphs=double(wgraphs>0.1);

% Compute pairwise distance
D=graph_todist(graphs);

% Compute reliability
mnr=compute_mnr(D, [1:50 1:50]);