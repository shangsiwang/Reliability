
%%%generate plots for mrs knnmse knnerr on HCP data set with NEO
%%%Load HCP100_fig before running
x=(0:50)/50;
plot(x,mrs,'r*-','color','k')        
title('Reliability and Predictability Results on HCP100')
xlabel('Threshold on absolute correlation') 
ylabel('Stats') 
line('XData',x,'YData',IICC,'LineStyle', '-','Marker','*','color',[0.5 0 0.5])
line('XData',x,'YData',knnerr,'LineStyle', '-','Marker','*','color','r')
line('XData',x,'YData',knnmse/20,'LineStyle', '-','Marker','*','color','b')

neoa=(knnneo(1,:)-min(knnneo(1,:)))/mean(knnneo(1,:));
line('XData',x,'YData',neoa,'LineStyle', '-','Marker','*','color','c')
neoo=(knnneo(2,:)-min(knnneo(2,:)))/mean(knnneo(2,:));
line('XData',x,'YData',neoo,'LineStyle', '-','Marker','*','color','m')
neoc=(knnneo(3,:)-min(knnneo(3,:)))/mean(knnneo(3,:));
line('XData',x,'YData',neoc,'LineStyle', '-','Marker','*','color','y')
neon=(knnneo(4,:)-min(knnneo(4,:)))/mean(knnneo(4,:));
line('XData',x,'YData',neon,'LineStyle', '-','Marker','*','color',[0 0.5 0.5])
neoe=(knnneo(5,:)-min(knnneo(5,:)))/mean(knnneo(5,:));
line('XData',x,'YData',neoe,'LineStyle', '-','Marker','*','color',[0.5 0.5 0.5])

ind=find(mrs==min(mrs));
loc=ind(1)*0.02-0.02;
hold on
%line('XData',[loc loc],'YData', [0 1],'color','k','LineStyle', ':','LineWidth',2)
plot(loc,mrs(ind),'Marker','o','MarkerSize',8,'color','k','MarkerFaceColor','k')

ind=find(IICC==max(IICC));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color',[0.5 0 0.5],'LineStyle', ':','LineWidth',2)
plot(loc,IICC(ind),'Marker','o','MarkerSize',8,'color',[0.5 0 0.5],'MarkerFaceColor',[0.5 0 0.5])

ind=find(knnerr==min(knnerr));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color','r','LineStyle', ':','LineWidth',2)
plot(loc,knnerr(ind),'Marker','o','MarkerSize',8,'color','r','MarkerFaceColor','r')

ind=find(knnmse==min(knnmse));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color','b','LineStyle', ':','LineWidth',2)
plot(loc,knnmse(ind)/20,'Marker','o','MarkerSize',8,'color','b','MarkerFaceColor','b')

ind=find(neoa==min(neoa));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color','c','LineStyle', ':','LineWidth',2)
plot(loc,neoa(ind),'Marker','o','MarkerSize',8,'color','c','MarkerFaceColor','c')

ind=find(neoo==min(neoo));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color','m','LineStyle', ':','LineWidth',2)
plot(loc,neoo(ind),'Marker','o','MarkerSize',8,'color','m','MarkerFaceColor','m')

ind=find(neoc==min(neoc));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color','y','LineStyle', ':','LineWidth',2)
plot(loc,neoc(ind),'Marker','o','MarkerSize',8,'color','y','MarkerFaceColor','y')

ind=find(neon==min(neon));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color',[0 0.5 0.5],'LineStyle', ':','LineWidth',2)
plot(loc,neon(ind),'Marker','o','MarkerSize',8,'color',[0 0.5 0.5],'MarkerFaceColor',[0 0.5 0.5])

ind=find(neoe==min(neoe));
loc=ind(1)*0.02-0.02;
%line('XData',[loc loc],'YData', [0 1],'color',[0.5 0.5 0.5],'LineStyle', ':','LineWidth',2)
plot(loc,neoe(ind),'Marker','o','MarkerSize',8,'color',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5])


legend('MNR','I2C2','ERR','MSE','NEOA','NEOO','NEOC','NEON','NEOE','Location','eastoutside');
ylim([0 0.8]);
hold off