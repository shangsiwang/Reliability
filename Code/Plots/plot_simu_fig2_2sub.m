%% %%%%% Load data
load('simu_fig2_2sub_data1')
%% %%%%% Plot results of experiment 2 but only 2 subject
n=n/2;
subplot(4,2,1)
colors=[repmat([0.9,0.5,0.1],n,1);repmat([0.5,0.9,0.1],n,1)];
scatter(O(:,1),O(:,2),8,colors,'filled')
title('Scatter Plot of Samples')
xlim([-10 10])
ylim([-10 10])

subplot(4,2,3)
[f,xi]=ksdensity((wBERR*O(1:n,1)+O(1:n,2))/sqrt(1+wBERR^2));
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity((wBERR*O((n+1):(2*n),1)+O((n+1):(2*n),2))/sqrt(1+wBERR^2));
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on Bayes Error')
hold off

subplot(4,2,5)
[f,xi]=ksdensity((wVAR*O(1:n,1)+O(1:n,2))/sqrt(1+wVAR^2));
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity((wVAR*O((n+1):(2*n),1)+O((n+1):(2*n),2))/sqrt(1+wVAR^2));
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on PCA')
hold off

subplot(4,2,7)
[f,xi]=ksdensity((wMNR*O(1:n,1)+O(1:n,2))/sqrt(1+wMNR^2));
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity((wMNR*O((n+1):(2*n),1)+O((n+1):(2*n),2))/sqrt(1+wMNR^2));
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on MNR')
hold off



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%% Load data
clear all
load('simu_fig2_2sub_data2')
%% %%%%% Plot results
n=n/2;
subplot(4,2,2)
colors=[repmat([0.9,0.5,0.1],n,1);repmat([0.5,0.9,0.1],n,1)];
scatter(O(:,1),O(:,2),8,colors,'filled')
title('Scatter Plot of Samples')
xlim([-10 10])
ylim([-10 10])

subplot(4,2,4)
[f,xi]=ksdensity((wBERR*O(1:n,1)+O(1:n,2))/sqrt(1+wBERR^2));
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity((wBERR*O((n+1):(2*n),1)+O((n+1):(2*n),2))/sqrt(1+wBERR^2));
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on Bayes Error')
hold off

subplot(4,2,6)
[f,xi]=ksdensity((wVAR*O(1:n,1)+O(1:n,2))/sqrt(1+wVAR^2));
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity((wVAR*O((n+1):(2*n),1)+O((n+1):(2*n),2))/sqrt(1+wVAR^2));
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on PCA')
hold off

subplot(4,2,8)
[f,xi]=ksdensity((wMNR*O(1:n,1)+O(1:n,2))/sqrt(1+wMNR^2));
plot(xi,f,'LineWidth',2.5,'Color','y')
hold on
[f,xi]=ksdensity((wMNR*O((n+1):(2*n),1)+O((n+1):(2*n),2))/sqrt(1+wMNR^2));
plot(xi,f,'LineWidth',2.5,'Color','g')
title('Optimal Projection Based on MNR')
hold off