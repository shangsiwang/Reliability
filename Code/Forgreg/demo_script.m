% Script to demonstrate how to use those functions
TimeSeries=randn(50,180,100); % roi*T*nsubect

% Convert Time series to weighted graphs
wgraphs=build_graph(TimeSeries);

% Threshold at 0.1
graphs=double(wgraphs>0.1);

% Compute pairwise distance
% D=graph_todist(graphs);
% id=[1:50 1:50];

smg = loadkki('/Users/gkiar/code/scratch/safekeeping/bc1/run2/');
D = graph_todist(smg);
id = ceil(0.5:0.5:21);
figure (1); %subplot(121);
imagesc(D);
col=winter;
colormap(col);colorbar;

% Compute reliability
mnr=compute_mnr(D, id);

xlabel('scan'), ylabel('scan'), title(strcat('Test-ReTest Reliability; MNR= ', num2str(mnr)));


%% hellinger distance
intra=[]; inter = [];
for i=1:length(id)
    for j=i+1:length(id)
        if id(i) == id(j)
            intra = [intra, D(i,j)];
        else
            inter = [inter, D(i,j)];
        end
    end
end

figure(2); %subplot(122);
[~, x_intra] = ksdensity(intra);
[~, x_inter] = ksdensity(inter);
lims = [min([x_intra,x_inter]), max([x_intra, x_inter])]; %innefficient but works...
xrange = lims(1):range(lims)/300:lims(2);

[f_intra] = ksdensity(intra, xrange);
[f_inter] = ksdensity(inter, xrange);

H = norm(sqrt(f_intra)- sqrt(f_inter),2)/sqrt(2);

f_over = min(f_intra, f_inter);
fill(xrange, f_intra, col(1,:), xrange, f_inter, col(end,:), xrange, f_over, col(end/2,:))
legend('Intra Subject Kernel Estimate', 'Inter Subject Kernel Estimate', 'Location', 'NorthWest');
title(strcat('Hellinger Distance=', num2str(H), '; p < 10^-^5'));
ylabel('probability'), xlabel('graph difference')
%% Compute Null Distribution and Hellinger
%{
hperm = [];
for ii = 1:10000
    N = randperm(length(id));
    tempg = D(N, N);
    
    n_intra=[]; n_inter = [];
    for i=1:length(id)
        for j=i+1:length(id)
            if id(i) == id(j)
                n_intra = [n_intra, tempg(i,j)];
            else
                n_inter = [n_inter, tempg(i,j)];
            end
        end
    end
    
    
    [~, nx_intra] = ksdensity(n_intra);
    [~, nx_inter] = ksdensity(n_inter);
    lims = [min([nx_intra,nx_inter]), max([nx_intra, nx_inter])]; %innefficient but works...
    nxrange = lims(1):range(lims)/300:lims(2);
    
    [nf_intra] = ksdensity(n_intra, nxrange);
    [nf_inter] = ksdensity(n_inter, nxrange);
    plot(nxrange, nf_intra, nxrange, nf_inter)
    pause;
    
    hperm = [hperm, norm(sqrt(nf_intra)- sqrt(nf_inter),2)/sqrt(2)];
end

pval = sum(hperm >= H) ./ length(hperm)

%}