%% %%%%Violin Plots
load('simu_fig3_data')
violin(simuMnr','xlabel',{'10','20','50','100','200'},'edgecolor','none','facecolor','r')
ylabel('Mean Normalized Rank')
xlabel('Sample Size')
title('Convergence of Mean Normalized Rank')
hold on
for i=1:5
mMNR(i)=mean(simuMnr(i,:));
eMNR(i)=sqrt(var(simuMnr(i,:)));
p1=plot(i,mMNR(i),'Marker','+','MarkerSize',10,'color','b');
p2=plot(i,theoMnr,'Marker','x','MarkerSize',10,'color','k');
end
L=legend([p1 p2],'Simulation Mean','Theoretical MNR');
set(L,'box','off');
hold off