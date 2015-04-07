%Perform simulation experiment 2
%Observations in 2-d are generated and projected to 1-d space
%% %%%%% First experiment
%% %%%%% Generate data
n=400; %total number of subjects,n/2 subjects from each class
%2 scans from each subject, class conditionals are 2d mvn guassian
%noise are also mvn gaussian

MU1=[-1 0];
MU2=[1 0];
SIGMA=[4 0; 0 1];
X1=mvnrnd(MU1,SIGMA,n/2);
X2=mvnrnd(MU2,SIGMA,n/2);
SIGMA=[2 0; 0 1];
O11=X1+mvnrnd([0 0],SIGMA,n/2);
O12=X1+mvnrnd([0 0],SIGMA,n/2);
O21=X2+mvnrnd([0 0],SIGMA,n/2);
O22=X2+mvnrnd([0 0],SIGMA,n/2);
O=[O11;O12;O21;O22];
    
%% %%%%% Compute statistics with weights varies
weights=[(0:20)/20 2.5 3 5 7 10 100];
MNR=zeros(1,length(weights));
VAR=zeros(1,length(weights));
BERR=zeros(1,length(weights));
    for w=1:length(weights)
    w1=weights(w);
    O_1d=(w1*O(:,1)+O(:,2))/sqrt(1+w1^2);
    
    
    D=zeros(2*n,2*n);
    for i=1:(2*n)
        for j=(i+1):(2*n)
            Dij=norm(O_1d(i,:)-O_1d(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    
    ID=[1:(n/2) 1:(n/2) (n/2+1):n  (n/2+1):n];
    MNR(w)=compute_mnr(D,ID);
    VAR(w)=var(O_1d);
    BERR(w)=normcdf(-(2*w1)/sqrt(5*w1^2+2));
    end

    
    
%% %%%%% Find optimal weights    
[~,index]=min(MNR);
wMNR=weights(index);
[~,index]=max(VAR);
wVAR=weights(index);
[~,index]=min(BERR);
wBERR=weights(index);

%% %%%%Save data
currentdir=pwd;
lastSlashPosition = find(currentdir == '\', 1, 'last');
parentdir = currentdir(1:lastSlashPosition-1);
savedir=strcat(parentdir,'\Plots\simu_fig2_data1');
save(savedir,'O','wBERR','wMNR','wVAR','n');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%Second experiment
n=400; %total number of subjects, 2 scans from each subject

MU1=[-1 0];
MU2=[1 0];
SIGMA=[1 0; 0 4];
X1=mvnrnd(MU1,SIGMA,n/2);
X2=mvnrnd(MU2,SIGMA,n/2);
SIGMA=[1 0; 0 2];
O11=X1+mvnrnd([0 0],SIGMA,n/2);
O12=X1+mvnrnd([0 0],SIGMA,n/2);
O21=X2+mvnrnd([0 0],SIGMA,n/2);
O22=X2+mvnrnd([0 0],SIGMA,n/2);
O=[O11;O12;O21;O22];
    
%% %%%%% Compute statistics with weights varies
weights=[(0:20)/20 2.5 3 5 7 10 100];
MNR=zeros(1,length(weights));
VAR=zeros(1,length(weights));
BERR=zeros(1,length(weights));
    for w=1:length(weights)
    w1=weights(w);
    O_1d=(w1*O(:,1)+O(:,2))/sqrt(1+w1^2);
    
    
    D=zeros(2*n,2*n);
    for i=1:(2*n)
        for j=(i+1):(2*n)
            Dij=norm(O_1d(i,:)-O_1d(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    
    ID=[1:(n/2) 1:(n/2) (n/2+1):n  (n/2+1):n];
    MNR(w)=compute_mnr(D,ID);
    VAR(w)=var(O_1d);
    BERR(w)=normcdf(-(2*w1)/sqrt(6+w1^2));
    end

    
    
%% %%%%% Find optimal weights    
[~,index]=min(MNR);
wMNR=weights(index);
[~,index]=max(VAR);
wVAR=weights(index);
[~,index]=min(BERR);
wBERR=weights(index);

%% %%%%Save data
currentdir=pwd;
lastSlashPosition = find(currentdir == '\', 1, 'last');
parentdir = currentdir(1:lastSlashPosition-1);
savedir=strcat(parentdir,'\Plots\simu_fig2_data2');
save(savedir,'O','wBERR','wMNR','wVAR','n');

