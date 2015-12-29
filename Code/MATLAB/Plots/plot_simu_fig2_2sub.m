%% %%%%% Load data
load('simu_fig2_2sub_data1')
%% %%%%% Plot results of experiment 1 but only 2 subject
n=n/2;
subplot(5,2,1)
colors=[repmat([0.9,0.5,0.1],n,1);repmat([0.5,0.9,0.1],n,1)];
scatter(O(:,1),O(:,2),8,colors,'filled')
title('Scatter Plot of Samples')
xlim([-10 10])
ylim([-10 10])

subplot(5,2,3)
[f,xi]=ksdensity(O(1:n,:)*wBERR);
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity(O((n+1):(2*n),:)*wBERR);
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on Bayes Error')
hold off

subplot(5,2,5)
[f,xi]=ksdensity(O(1:n,:)*wVAR);
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity(O((n+1):(2*n),:)*wVAR);
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on PCA')
hold off

subplot(5,2,7)
[f,xi]=ksdensity(-O(1:n,:)*wMNR);
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity(-O((n+1):(2*n),:)*wMNR);
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on Reliability')
hold off

subplot(5,2,9)
plot((0:19)/20*pi,1-MNR,'LineWidth',2.5,'Color','b')
hold on
plot((0:19)/20*pi,1-BERR,'LineWidth',2.5,'Color','r')
title('Reliability and Bayes Error vs Projection Angle')
ylim([0.1 0.8])
hold off
xlim([0 pi])
set(gca,'XTick',[0 0.5*pi pi])
set(gca,'XTickLabel',{'0', '180', '360'})




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%% Load data
clear all
load('simu_fig2_2sub_data2')
%% %%%%% Plot results
n=n/2;
subplot(5,2,2)
colors=[repmat([0.9,0.5,0.1],n,1);repmat([0.5,0.9,0.1],n,1)];
scatter(O(:,1),O(:,2),8,colors,'filled')
title('Scatter Plot of Samples')
xlim([-10 10])
ylim([-10 10])

subplot(5,2,4)
[f,xi]=ksdensity(O(1:n,:)*wBERR);
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity(O((n+1):(2*n),:)*wBERR);
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on Bayes Error')
hold off

subplot(5,2,6)
[f,xi]=ksdensity(O(1:n,:)*wVAR);
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity(O((n+1):(2*n),:)*wVAR);
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on PCA')
hold off

subplot(5,2,8)
[f,xi]=ksdensity(O(1:n,:)*wMNR);
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity(O((n+1):(2*n),:)*wMNR);
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on Reliability')
hold off

subplot(5,2,10)
plot((0:19)/20*pi,1-MNR,'LineWidth',2.5,'Color','b')
hold on
plot((0:19)/20*pi,1-BERR,'LineWidth',2.5,'Color','r')
title('Reliability and Bayes Error vs Projection Angle')
ylim([0.1 0.8])
hold off
xlim([0 pi])
set(gca,'XTick',[0 0.5*pi pi])
set(gca,'XTickLabel',{'0', '180', '360'})
