function [mnrfull, tvals, mnrval, tvalmax, roinum, Dist] = process_mult_studies(files,...
    numsubs, numstudies, method, rank)
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
tvalmax = zeros(numatlases, 1);
tvals = zeros(numatlases, 25);
roinum = zeros(1, numatlases);
Dist = zeros(numsubs, numsubs, numatlases);
for fileval=1:numatlases
    display(fileval);
    clear ts wgraphs tgraph smg D E distmtx mnrmtx tvalcorr
    clear mnr mnrtest dist 
    ts = opents_mult(files, numsubs, numstudies, fileval);



    % Convert Time series to weighted graphs
    % method can be the build_graph, ts2pcorr, ts2cov, ts2invcov
    wgraphs=[];
    for studiter = 1:numstudies
        wgraphs = cat(3,wgraphs,method(cell2mat(ts{studiter})));
    end
    
    if rank == 1
        wgraphs = matrix_tiedrank(wgraphs);
    end
    size(wgraphs)
    numrois = size(wgraphs, 1);
    roinum(fileval) = numrois;

    display(numrois);
    % Compute pairwise distance

    id = ceil(0.5:0.5:numsubs/2);
    %%begin thresholding to find minimum mnr
    
    [mnrall, D, mnrmax, tval, tvalall] = thresh_functional_corr(wgraphs, id);
    mnrfull(fileval,:) = mnrall;
    mnrval(fileval,:) = mnrmax;
    tvals(fileval,:) = tvalall;
    tvalmax(fileval) = tval;
    Dist(:,:,fileval) = D;
    
    figure (1); %subplot(121);
    imagesc(D);
    col=winter;
    colormap(col);colorbar;

    % Compute reliability
    xlabel('scan');
    ylabel('scan');
    title(sprintf('Test-ReTest Reliability; numrois = %d, threshold= %f, MNR= %f', numrois, tval, mnrmax));
    savefig(sprintf('distmtx%d.fig', numrois));

    %% hellinger distance
    intra=[]; intersub = []; interstud = [];
    for i=1:length(id)
        for j=i+1:length(id)
            if id(i) == id(j)
                intra = [intra, D(i,j)];
            elseif files(i).studyval == files(j).studyval
                intersub = [intersub, D(i,j)];
            else
                interstud = [interstud, D(i,j)];
            end
        end
    end

    figure(2); %subplot(122);
    [~, x_intra] = ksdensity(intra);
    [~, x_intersub] = ksdensity(intersub);
    [~, x_interstud] = ksdensity(interstud);
    lims = [min([x_intra,x_intersub, x_interstud]), max([x_intra, x_intersub, x_interstud])]; %innefficient but works...
    xrange = lims(1):range(lims)/300:lims(2);

    [f_intra] = ksdensity(intra, xrange);
    [f_intersub] = ksdensity(intersub, xrange);
    [f_interstud] = ksdensity(interstud, xrange);
    H_intra_intersub = norm(sqrt(f_intra)- sqrt(f_intersub),2)/sqrt(2);
    H_intra_interstud = norm(sqrt(f_intra) - sqrt(f_interstud),2)/sqrt(2);
    H_intersub_interstud = norm(sqrt(f_intersub) - sqrt(f_interstud),2)/sqrt(2);
    purp= [150, 89, 152]/255;
    %%% left off here... need to define all the possible overlap conditions
    f_overlap_intra_intersub=min(f_intra, f_intersub);
    f_overlap_intra_interstud=min(f_intra,f_interstud);
    f_overlap_intersub_interstud=min(f_intersub,f_interstud);
    f_overlap_all = max(max(f_overlap_intra_intersub, f_overlap_intra_interstud),f_overlap_intersub_interstud);

    colalt=copper;
    fill(xrange, f_intra, col(1,:), xrange, f_intersub, col(end,:),...
        xrange, f_interstud, colalt(end,:), xrange, f_overlap_all, col(length(col)/2+6,:));
    legend('Intra Subject', 'Inter Subject',...
        'Inter Study','Overlap', 'Location', 'NorthWest');
    title(strcat('H_intr_intersub=', num2str(H_intra_intersub), ' H_intr_interstud=',...
        num2str(H_intra_interstud), '\n', 'H_intersub_interstud=',...
        num2str(H_intersub_interstud),'; numrois=', num2str(numrois)));
    ylabel('probability');
    xlabel('graph difference');
    savefig(sprintf('helldistcmpr%d.fig', numrois));
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
