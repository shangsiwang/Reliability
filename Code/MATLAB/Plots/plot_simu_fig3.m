%% %%%%Violin Plots
load('simu_fig3_data')
violin(1-simuMnr','xlabel',{'10','20','50','100','200'},'edgecolor','none','facecolor','r')
ylabel('Sample Reliability')
xlabel('Sample Size')
title('Convergence of Sample Reliability')
hold on
for i=1:5
mMNR(i)=mean(1-simuMnr(i,:));
eMNR(i)=sqrt(var(simuMnr(i,:)));
p1=plot(i,mMNR(i),'Marker','+','MarkerSize',10,'color','b');
p2=plot(i,1-theoMnr,'Marker','x','MarkerSize',10,'color','k');
end
L=legend([p1 p2],'Simulation Mean','True Reliability');
set(L,'box','off');
hold off