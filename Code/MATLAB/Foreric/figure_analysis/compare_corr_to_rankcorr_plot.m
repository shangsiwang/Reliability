clear all
close all
filez=dir('outputs*.mat');
numsubs=42;
for i =1:length(filez)
   load(filez(i).name);
end

xvals=linspace(0,1,25);
for i=1:length(rois)
    roival=rois(i);  % the value of the roi being inspected

    
    dist=openfig(sprintf('distmtx%d.fig', roival),'reuse');
    distax=gca;
    hell=openfig(sprintf('helldist%d.fig',roival),'reuse');
    hellax=gca;
    helltitle=get(gca, 'Title');
    helltitle=helltitle.String(1:end-1);
    distrank=openfig(sprintf('distmtxrank%d.fig',roival),'reuse');
    distrankax=gca;
    hellrank=openfig(sprintf('helldistrank%d.fig', roival),'reuse');
    hellrankax=gca;
    hellranktitle=get(gca, 'Title');
    hellranktitle=hellranktitle.String(1:end-1);
    z=figure;
    s1=subplot(3,2,1);
    s2=subplot(3,2,2);
    s3=subplot(3,2,3);
    s4=subplot(3,2,4);
    
    fig1=get(distax,'children');
    fig2=get(hellax,'children');
    fig3=get(distrankax,'children');
    fig4=get(hellrankax,'children');
    
    copyobj(fig1,s1);
    subplot(3,2,1);
    xlabel('scan');
    ylabel('scan');
    title(sprintf('Correlation; numrois=%d, mnr=%.4f',roival, mnr(i)));
    ax=gca;
    ax.FontSize=6;
    colormap(winter);colorbar;
    axis([0 numsubs 0 numsubs]);
    
    copyobj(fig2,s3);
    subplot(3,2,2);
    xlabel('scan');
    ylabel('scan');
    colormap(winter);colorbar;
    title(sprintf('Rank-Correlation; numrois=%d, mnr=%.4f',roival, mnrrank(i)));
    ax=gca;
    ax.FontSize=6;
    axis([0 numsubs 0 numsubs]);
    
    copyobj(fig3,s2);
    subplot(3,2,3);
    legend('intra', 'inter', 'overlap');
    xlabel('graph difference');
    ylabel('probability');
    ax=gca;
    ax.FontSize=6;
    title(strcat(helltitle, num2str(roival)));
    
    copyobj(fig4,s4);
    subplot(3,2,4);
    ax=gca;
    ax.FontSize=6;    
    legend('intra', 'inter', 'overlap');
    xlabel('graph difference');
    ylabel('probability');
    title(strcat(hellranktitle, num2str(roival)));
    
    subplot(3,2,5);
    plot(xvals,mnrfull(i,:));
    axis([0 1 .4 1])
    xlabel('threshold');
    ylabel('mnr');
    ax=gca;
    ax.FontSize=6;    
    
    subplot(3,2,6);
    plot(xvals,mnrfullrank(i,:));    
    axis([0 1 .4 1])
    xlabel('normalized threshold');
    ylabel('mnr');
    ax=gca;
    ax.FontSize=6;    
    
    saveas(z, sprintf('comparison%d.jpg', roival));
end