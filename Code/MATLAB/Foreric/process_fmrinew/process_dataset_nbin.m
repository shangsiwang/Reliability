function [mnrfull, tvals, mnrval, tvalmax, roinum, Dist] = process_dataset_nbin(files, numsubs, method, rank, dataset)
% a processing function for a set of ts
% can process any number of ts at once given the files in 
% expected format in addition to the number of atlases
%
% Outputs
%   mnrfull: the full list of mnrvalues for the particular dataset; tracks
%       the mnr at each threshold point
%   mnrval: a list of the minimum mnr values for the dataset in each atlas

numatlases = length(files)/numsubs;
mnrfull = zeros(numatlases, 25);
mnrval = zeros(numatlases, 1);
tvalmax = zeros(numatlases, 1);\
tvals = zeros(numatlases, 25);
roinum = zeros(1, numatlases);
Dist = zeros(numsubs, numsubs, numatlases);
for fileval=1:numatlases
    display(fileval);
    clear ts wgraphs tgraph smg D E distmtx mnrmtx tvalcorr
    clear mnr mnrtest dist 
    wgraphs = opents_nbin(files, numsubs, fileval);


    numrois = size(ts, 1);
    roinum(fileval) = numrois;

    display(numrois);
    % Convert Time series to weighted graphs
    % method can be the build_graph, ts2pcorr, ts2cov, ts2invcov

    
    if rank == 1
        wgraphs = matrix_tiedrank(wgraphs);
    end
    
    % Compute pairwise distance

    id = ceil(0.5:0.5:numsubs/2);
    %%begin thresholding to find minimum mnr
    
    [tval, mnrall, tvalall, rdf, bin_graphs] = find_nbinstar(graphs, id, true, 50, 'lin');
    mnrfull(fileval,:) = mnrall;
    mnrval(fileval,:) = max(mnrall);
    tvals(fileval,:) = tvalall;
    tvalmax(fileval) = tval;
    
    D = graph_todist(bin_graphs);
    Dist(:,:,fileval) = D;
    
    subplot(1,3,1);
    plot(tvalall(1:(end-1))/max(tvalall(1:end)),mnrall(1:end-1), 'bo'); title(strcat(dataset, sprintf(' nrois=%d, nsubs=%d', numrois, numsubs)));
    xlabel('normalized threshold');
    ylabel('mnr');
    
    subplot(1,3,2); %subplot(121);
    imagesc(D);
    col=winter;
    colormap(col);colorbar;

    % Compute reliability
    xlabel('scan');
    ylabel('scan');
    title(sprintf('thresh=%.3G, MNR= %.3f',tval, mnrmax));
    savefig(sprintf('distmtx%d.fig', numrois));

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

    subplot(1,3,3); %subplot(122);
    [~, x_intra] = ksdensity(intra);
    [~, x_inter] = ksdensity(inter);
    lims = [min([x_intra,x_inter]), max([x_intra, x_inter])]; %innefficient but works...
    xrange = lims(1):range(lims)/300:lims(2);

    [f_intra] = ksdensity(intra, xrange);
    [f_inter] = ksdensity(inter, xrange);

    H = norm(sqrt(f_intra)- sqrt(f_inter),2)/sqrt(2);

    purp= [150, 89, 152]/255;

    f_overlap = min(f_intra, f_inter);

    fill(xrange, f_intra, col(1,:), xrange, f_inter, col(end,:), xrange, f_overlap, col(length(col)/2+6,:))
    legend('Intra Subject Kernel Estimate', 'Inter Subject Kernel Estimate','Overlap', 'Location', 'NorthWest');
    title(sprintf('Hellinger Distance=%.3f', H));
    ylabel('probability');
    xlabel('graph difference');
    savefig(sprintf('helldist%d.fig', numrois));
    %% Compute Null Distribution and Hellinger
    % figure()
    % hperm = [];
    % for ii = 1:100000
    %     N = randperm(length(id));
    %     tempg = D(N, N);
    %     
    %     n_intra=[]; n_inter = [];
    %     for i=1:length(id)
    %         for j=i+1:length(id)
    %             if id(i) == id(j)
    %                 n_intra = [n_intra, tempg(i,j)];
    %             else
    %                 n_inter = [n_inter, tempg(i,j)];
    %             end
    %         end
    %     end
    %     
    %     
    %     [~, nx_intra] = ksdensity(n_intra);
    %     [~, nx_inter] = ksdensity(n_inter);
    %     lims = [min([nx_intra,nx_inter]), max([nx_intra, nx_inter])]; %innefficient but works...
    %     nxrange = lims(1):range(lims)/300:lims(2);
    %     
    %     [nf_intra] = ksdensity(n_intra, nxrange);
    %     [nf_inter] = ksdensity(n_inter, nxrange);
    %     plot(nxrange, nf_intra, nxrange, nf_inter)
    %     pause;
    %     hperm = [hperm, norm(sqrt(nf_intra)- sqrt(nf_inter),2)/sqrt(2)];
    %     display(hperm)
    % end
    % 
    % pval = sum(hperm >= H) ./ length(hperm) 

    %    save(sprintf('iteration%d.mat', fileval));
end 
