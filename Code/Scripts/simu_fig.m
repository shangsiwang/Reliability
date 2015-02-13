%Perform simulation experiment
%Experiment 1 is additive independent Gaussian noise
%Experiment 2 is additive Correlated Gaussain noise
%Experiment 3 is additive Laplacian noise
%Experiment 4 is missing
%%%%Experiment 1
rep=100; %number of repetions
n=100; %total number of scans, n/2 number of scans from each subject 
dim=2; % dimension of the data

B=zeros(rep,4);
for iter=1:rep
    MU1=[1 -1];
    MU2=[1 1];
    SIGMA=[1 0; 0 2];
    O1=mvnrnd(MU1,SIGMA,n/2);
    O2=mvnrnd(MU2,SIGMA,n/2);
    O=[O1 ; O2];


D=zeros(n,n);
for i=1:n
    for j=(i+1):n
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[ones(1,n/2)  ones(1,n/2)*2];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,1)
plot(O1(:,1),O1(:,2),'.','Color','r');
hold on
plot(O2(:,1),O2(:,2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
hold off
subplot(2,4,5)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);



%%%%%%%%%%%%%%%%
%%%%Experiment 2
B=zeros(rep,4);
Q=[1 -1 ; 1 1]/sqrt(2);
for iter=1:rep

    MU1=[0 -1];
    MU2=[0 1];
    SIGMA=[1 0; 0 2];
    O1=mvnrnd(MU1,SIGMA,n/2)*Q;
    O2=mvnrnd(MU2,SIGMA,n/2)*Q;
    O=[O1 ; O2];


D=zeros(n,n);
for i=1:n
    for j=(i+1):n
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[ones(1,n/2)  ones(1,n/2)*2];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,2)
plot(O1(:,1),O1(:,2),'.','Color','r');
hold on
plot(O2(:,1),O2(:,2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
hold off
subplot(2,4,6)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);


%%%%Experiment 3
B=zeros(rep,4);
for iter=1:rep
    
    O1=(binornd(1,0.5,n/2,2)*2-1).*exprnd(1/sqrt(2),n/2,2);
    O1(:,2)=O1(:,2)*sqrt(2)-1;
    O1(:,1)=O1(:,1)+1;
    O2=(binornd(1,0.5,n/2,2)*2-1).*exprnd(1/sqrt(2),n/2,2);
    O2(:,2)=O2(:,2)*sqrt(2)+1;
    O2(:,1)=O2(:,1)+1;
    O=[O1 ; O2];

D=zeros(n,n);
for i=1:n
    for j=(i+1):n
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[ones(1,n/2)  ones(1,n/2)*2];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,3)
plot(O1(:,1),O1(:,2),'.','Color','r');
hold on
plot(O2(:,1),O2(:,2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
hold off
subplot(2,4,7)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);

%%%%Experiment 4
B=zeros(rep,4);
for iter=1:rep
    
    s1=log(2);
    s2=log(3);
    MU1=[-s1 -s2]/2;
    MU2=[-s1 -s2]/2;
    SIGMA=[s1 0; 0 s2];
    O1=exp(mvnrnd(MU1,SIGMA,n/2));
    O2=exp(mvnrnd(MU2,SIGMA,n/2));
    O1(:,2)=-O1(:,2);
    O=[O1 ; O2];

D=zeros(n,n);
for i=1:n
    for j=(i+1):n
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[ones(1,n/2)  ones(1,n/2)*2];
B(iter,1)=compute_i2c2(O(:,1),ID);
B(iter,2)=compute_i2c2(O(:,2),ID);
B(iter,3)=compute_i2c2(O,ID);
B(iter,4)=compute_mnr(D,ID);
end

subplot(2,4,4)
plot(O1(:,1),O1(:,2),'.','Color','r');
hold on
plot(O2(:,1),O2(:,2),'.','Color','b');
ylim([-6 6]);
xlim([-3 5]);
hold off
subplot(2,4,8)
boxplot(B,'labels',{'ICC1' 'ICC2' 'I2C2' 'MNR'});
ylim([-0.1 0.7]);
