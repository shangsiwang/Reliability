function nbinstar = find_nbin(graphs, ids)
%Takes passed-to-rank graphs, returns the optimal number of dimensions to
%build the histogram in.
nbinstar = [0];

%normalize graphs
for i=1:size(graphs,3)
    graph_norm(:,:,i) = (graphs(:,:,i) - min2(graphs(:,:,i)))/ ...
                        (max2(graphs(:,:,i)) - min2(graphs(:,:,i)));
end 

for i=2:50; %try 100 bins
    p = 1/i;
    tempg = zeros(size(graphs));
    for j=1:i-1
        tempg = tempg + (graphs > j*p);
    end
%     figure(4); imagesc(tempg(:,:,1)); colorbar; caxis([0 j]);
    
    tempd = graph_todist(double(tempg));
    mnr(i-1) = compute_mnr(tempd, ids);
end
figure;
plot(mnr);
is = 2:100;
nbinstar = is(find(mnr==min(mnr)));

end