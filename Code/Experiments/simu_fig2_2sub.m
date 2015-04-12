%Perform simulation experiment 2 but only 2 subject
%Observations in 2-d are generated and projected to 1-d space
%% %%%%% First experiment
%% %%%%% Generate data
n=400; % n/2 scans for each subject
MU1=[-1 0];
MU2=[1 0];
SIGMA=[4 0; 0 1];
X1=mvnrnd(MU1,SIGMA,n/2);
X2=mvnrnd(MU2,SIGMA,n/2);
O=[X1;X2];
    
%% %%%%% Compute statistics with weights varies
weights=[(0:20)/20 2.5 3 5 7 10 100];
MNR=zeros(1,length(weights));
VAR=zeros(1,length(weights));
BERR=zeros(1,length(weights));
    for w=1:length(weights)
    w1=weights(w);
    O_1d=(w1*O(:,1)+O(:,2))/sqrt(1+w1^2);
    
    
    D=zeros(n,n);
    for i=1:(n)
        for j=(i+1):(n)
            Dij=norm(O_1d(i,:)-O_1d(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    
    ID=[ones(1,n/2) 2*ones(1,n/2)];
    MNR(w)=compute_mnr(D,ID);
    VAR(w)=var(O_1d);
    BERR(w)=normcdf(-(2*w1)/sqrt(4*w1^2+1));
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
savedir=strcat(parentdir,'\Plots\simu_fig2_2sub_data1');
save(savedir,'O','wBERR','wMNR','wVAR','n');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%Second experiment
n=400; % n/2 scans for each subject
MU1=[-1 0];
MU2=[1 0];
SIGMA=[1 0; 0 4];
X1=mvnrnd(MU1,SIGMA,n/2);
X2=mvnrnd(MU2,SIGMA,n/2);
O=[X1;X2];
    
%% %%%%% Compute statistics with weights varies
weights=[(0:20)/20 2.5 3 5 7 10 100];
MNR=zeros(1,length(weights));
VAR=zeros(1,length(weights));
BERR=zeros(1,length(weights));
    for w=1:length(weights)
    w1=weights(w);
    O_1d=(w1*O(:,1)+O(:,2))/sqrt(1+w1^2);
    
    
    D=zeros(n,n);
    for i=1:(n)
        for j=(i+1):(n)
            Dij=norm(O_1d(i,:)-O_1d(j,:));
            D(i,j)=Dij;
            D(j,i)=Dij;
        end
    end
    
    
    ID=[ones(1,n/2) 2*ones(1,n/2)];
    MNR(w)=compute_mnr(D,ID);
    VAR(w)=var(O_1d);
    BERR(w)=normcdf(-(2*w1)/sqrt(4+w1^2));
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
savedir=strcat(parentdir,'\Plots\simu_fig2_2sub_data2');
save(savedir,'O','wBERR','wMNR','wVAR','n');

