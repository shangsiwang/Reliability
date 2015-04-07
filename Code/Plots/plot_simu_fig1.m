load('simu_fig_data')
[n,~]=size(O1);
n=n/2;
%% %%%%%%%
subplot(2,4,1)
plot(O1(1:n,1),O1(1:n,2),'.','Color','r');
hold on
plot(O1((n+1):(2*n),1),O1((n+1):(2*n),2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
title('Additive Normal Noise');
hold off
subplot(2,4,5)
boxplot(B1,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);
%% %%%%%%%
subplot(2,4,2)
plot(O2(1:n,1),O2(1:n,2),'.','Color','r');
hold on
plot(O2((n+1):(2*n),1),O2((n+1):(2*n),2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
title('Additive Normal Noise');
hold off
subplot(2,4,6)
boxplot(B2,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);
%% %%%%%%%
subplot(2,4,3)
plot(O3(1:n,1),O3(1:n,2),'.','Color','r');
hold on
plot(O3((n+1):(2*n),1),O3((n+1):(2*n),2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
title('Additive Laplacian Noise');
hold off
subplot(2,4,7)
boxplot(B3,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);

%% %%%%%%%
subplot(2,4,4)
plot(O4(1:n,1),O4(1:n,2),'.','Color','r');
hold on
plot(O4((n+1):(2*n),1),O4((n+1):(2*n),2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
title('Muliplicative LogNormal Noise');
hold off
subplot(2,4,8)
boxplot(B4,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);