%Perform simulation experiment
%Experiment 1 is additive independent Gaussian noise
%Experiment 2 is additive Correlated Gaussain noise
%Experiment 3 is additive Laplacian noise
%Experiment 4 is missing
%%%%Experiment 1
rep=100;
sigma=1;
B=zeros(rep,4);
dim=20;
for iter=1:rep
O=zeros(400,dim);
    Xi=randn(200,dim);
    Z1=randn(200,dim);
    Z2=randn(200,dim);
    O(1:200,:)=Xi+sigma*Z1;
    O(201:400,:)=Xi+sigma*Z2;


D=zeros(400,400);
for i=1:400
    for j=(i+1):400
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[1:200 1:200];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,1)
scatter([Z1(:,1); Z2(:,1)],[Z1(:,2); Z2(:,2)],15,'filled');
subplot(2,4,5)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([0 0.7]);



%%%%%%%%%%%%%%%%
%%%%Experiment 2
B=zeros(rep,4);
for iter=1:rep
O=zeros(400,dim);
    Xi=randn(200,dim);
    Corr=randn(200,1)*0.8;
    Z1=randn(200,dim)*0.6+repmat(Corr,1,dim);
    Corr=randn(200,1)*0.8;
    Z2=randn(200,dim)*0.6+repmat(Corr,1,dim);
    O(1:200,:)=Xi+sigma*Z1;
    O(201:400,:)=Xi+sigma*Z2;


D=zeros(400,400);
for i=1:400
    for j=(i+1):400
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[1:200 1:200];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,2)
scatter([Z1(:,1); Z2(:,1)],[Z1(:,2); Z2(:,2)],15,'filled');
subplot(2,4,6)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([0 0.7]);



%%%%Experiment 3
B=zeros(rep,4);
for iter=1:rep
O=zeros(400,dim);
    Xi=randn(200,dim);
    %O(:,:,i)=Xi+sigma*(binornd(1,0.5,10,10)*2-1).*exprnd(1/sqrt(2),10,10);
    %O(:,:,i+200)=Xi+sigma*(binornd(1,0.5,10,10)*2-1).*exprnd(1/sqrt(2),10,10);
    %O(:,:,i)=Xi+sigma*randn(1)*ones(10,10);
    %O(:,:,i+200)=Xi+sigma*randn(1)*ones(10,10);
    Z1=(binornd(1,0.5,200,dim)*2-1).*exprnd(1/sqrt(2),200,dim);
    Z2=(binornd(1,0.5,200,dim)*2-1).*exprnd(1/sqrt(2),200,dim);
    O(1:200,:)=Xi+sigma*Z1;
    O(201:400,:)=Xi+sigma*Z2;


D=zeros(400,400);
for i=1:400
    for j=(i+1):400
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[1:200 1:200];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,3)
scatter([Z1(:,1); Z2(:,1)],[Z1(:,2); Z2(:,2)],15,'filled');
subplot(2,4,7)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([0 0.7]);
