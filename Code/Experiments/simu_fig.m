%Perform simulation experiment

rep=100; %number of repetions
n=100; %total number of scans, n/2 number of scans from each subject
dim=2; % dimension of the data

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Experiment 1 is additive independent Gaussian noise

B1=zeros(rep,4);
for iter=1:rep
    MU1=[1 -1];
    MU2=[1 1];
    SIGMA=[1 0; 0 2];
    O11=mvnrnd(MU1,SIGMA,n/2);
    O12=mvnrnd(MU2,SIGMA,n/2);
    O1=[O11 ; O12];
    
    D=zeros(n,n);
    for i=1:n
        for j=(i+1):n
            Dij=norm(O1(i,:)-O1(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    ID=[ones(1,n/2)  ones(1,n/2)*2];
    B1(iter,1)=compute_i2c2(O1(:,1),ID);
    B1(iter,2)=compute_i2c2(O1(:,2),ID);
    B1(iter,3)=compute_i2c2(O1,ID);
    B1(iter,4)=compute_mnr(D,ID);
end


%% %%%%%%%%%%%%%%
%%%%Experiment 2 is additive Correlated Gaussain noise

B2=zeros(rep,4);
Q=[1 -1 ; 1 1]/sqrt(2);
for iter=1:rep
    
    MU1=[0 -1];
    MU2=[0 1];
    SIGMA=[1 0; 0 2];
    O21=mvnrnd(MU1,SIGMA,n/2)*Q;
    O22=mvnrnd(MU2,SIGMA,n/2)*Q;
    O2=[O21 ; O22];
    
    
    D=zeros(n,n);
    for i=1:n
        for j=(i+1):n
            Dij=norm(O2(i,:)-O2(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    ID=[ones(1,n/2)  ones(1,n/2)*2];
    B2(iter,1)=compute_i2c2(O2(:,1),ID);
    B2(iter,2)=compute_i2c2(O2(:,2),ID);
    B2(iter,3)=compute_i2c2(O2,ID);
    B2(iter,4)=compute_mnr(D,ID);
end



%% %%%%%%%%%%%%%%
%%%%Experiment 3 is additive Laplacian noise

B3=zeros(rep,4);
for iter=1:rep
    
    O31=(binornd(1,0.5,n/2,2)*2-1).*exprnd(1/sqrt(2),n/2,2);
    O31(:,2)=O31(:,2)*sqrt(2)-1;
    O31(:,1)=O31(:,1)+1;
    O32=(binornd(1,0.5,n/2,2)*2-1).*exprnd(1/sqrt(2),n/2,2);
    O32(:,2)=O32(:,2)*sqrt(2)+1;
    O32(:,1)=O32(:,1)+1;
    O3=[O31 ; O32];
    
    D=zeros(n,n);
    for i=1:n
        for j=(i+1):n
            Dij=norm(O3(i,:)-O3(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    ID=[ones(1,n/2)  ones(1,n/2)*2];
    B3(iter,1)=compute_i2c2(O3(:,1),ID);
    B3(iter,2)=compute_i2c2(O3(:,2),ID);
    B3(iter,3)=compute_i2c2(O3,ID);
    B3(iter,4)=compute_mnr(D,ID);
end



%% %%%%%%%%%%%%%%
%%%%Experiment 4 Multiplicative Lognormal Noise

B=zeros(rep,4);
for iter=1:rep
    
    s1=log(2);
    s2=log(3);
    MU1=[-s1 -s2]/2;
    MU2=[-s1 -s2]/2;
    SIGMA=[s1 0; 0 s2];
    O41=exp(mvnrnd(MU1,SIGMA,n/2));
    O42=exp(mvnrnd(MU2,SIGMA,n/2));
    O41(:,2)=-O41(:,2);
    O4=[O41 ; O42];
    
    D=zeros(n,n);
    for i=1:n
        for j=(i+1):n
            Dij=norm(O4(i,:)-O4(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    ID=[ones(1,n/2)  ones(1,n/2)*2];
    B4(iter,1)=compute_i2c2(O4(:,1),ID);
    B4(iter,2)=compute_i2c2(O4(:,2),ID);
    B4(iter,3)=compute_i2c2(O4,ID);
    B4(iter,4)=compute_mnr(D,ID);
end

save simu_fig_data B1 B2 B3 B4 O1 O2 O3 O4
