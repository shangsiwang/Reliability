% Script to demonstrate how to use those functions
TimeSeries=randn(50,180,100); % roi*T*nsubect

% Convert Time series to weighted graphs
wgraphs=build_graph(TimeSeries);

% Threshold at 0.1
graphs=double(wgraphs>0.1);

% Compute pairwise distance
D1=graph_todist(graphs,'semipar');
D2=graph_todist(graphs);

% Compute reliability
mnr=compute_mnr(D1, [1:50 1:50]);

