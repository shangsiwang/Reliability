function [mnrfull, tvals, mnrval, tvalmax, roinum] = process_dataset_nbin(files, numsubs, numpipes, numslices, rank, setlist)
% a processing function for a set of ts
% can process any number of ts at once given the files in 
% expected format in addition to the number of atlases
%
% Outputs
%   mnrfull: the full list of mnrvalues for the particular dataset; tracks
%       the mnr at each threshold point
%   mnrval: a list of the minimum mnr values for the dataset in each atlas

mnrfull = zeros(numpipes, 50);
mnrval = zeros(numpipes, 1);
tvalmax = zeros(numpipes, 1);
tvals = zeros(numpipes, 1);
roinum = zeros(1, numpipes);
%Dist = zeros(numsubs, numsubs, numpipes);
for fileval=1:numpipes
    display(fileval);
    clear ts wgraphs tgraph smg D E distmtx mnrmtx tvalcorr
    clear mnr mnrtest dist 
    [wgraphs, numvalidsubs] = opents_nbin(files, numsubs, fileval,numslices);
    
    dataset=setlist{fileval};

    numrois = size(wgraphs, 1);
    roinum(fileval) = numrois;

    display(numrois);
    % Convert Time series to weighted graphs
    % method can be the build_graph, ts2pcorr, ts2cov, ts2invcov

    
    id = ceil(0.5:0.5:numvalidsubs/2);
    [mnralt, Dopt, mnrmaxalt, tvalmaxalt, tvalalt] = thresh_functional_corr(wgraphs, id, 50);
    if rank == 1
        wgraphs = matrix_tiedrank(wgraphs);
    end
    
    % Compute pairwise distance

    %%begin thresholding to find minimum mnr
    
    [tval, mnrall, tvalall, rdf, bin_graphs] = find_nbinstar(wgraphs, id, true, 50, 'lin');
    mnrfull(fileval,:) = mnrall;
    mnrval(fileval,:) = max(mnrall);
    tvals(fileval,1) = length(tvalall);
    tvalmax(fileval) = tval;
    
    D = graph_todist(bin_graphs);
    %Dist(:,:,fileval) = D;
    mnrmax=max(mnrall);
    subplot(1,3,1);
    plot(linspace(0,1,length(mnrall)),mnrall(1:end), 'bo'); title(strcat(dataset, sprintf(' nrois=%d, nsubs=%d', numrois, numsubs)));
    hold on;
    plot(linspace(0,1,length(tvalalt)), mnralt(1:end), 'ro'); legend('rank -> nbin*', 'thresholding');
    xlabel('normalized nbins');
    ylabel('mnr');
    
    subplot(1,3,2); %subplot(121);
    imagesc(D);
    col=winter;
    colormap(col);colorbar;

    % Compute reliability
    xlabel('scan');
    ylabel('scan');
    title(sprintf('nbins=%.3G, MNR= %.3f',tval, mnrmax));
    %savefig(sprintf('distmtx%d.fig', numrois));

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
    %savefig(sprintf('helldist%d.fig', numrois));
    
    savefig(strcat('fullplot', dataset, num2str(numrois), '.fig'));

end 
