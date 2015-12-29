%Perform simulation experiment 2 but only 2 subject
%Observations in 2-d are generated and projected to 1-d space
%% %%%%% Experiment number
Experiment=2; %can only be 1,2 or 3
%% %%%%%
%% %%%%% Generate data
n=400; % n/2 scans for each subject
MU1=[-1 0];
MU2=[1 0];
if(Experiment==1)
SIGMA=[4 0; 0 1];
end
if(Experiment==2)
SIGMA=[1 0; 0 4];
end
if(Experiment==3)
SIGMA=[1 0; 0 4];
end
X1=mvnrnd(MU1,SIGMA,n/2);
X2=mvnrnd(MU2,SIGMA,n/2);
O=[X1;X2];
if(Experiment==3)
O=O*[1 -1;1 1]/sqrt(2);
end
    
%% %%%%% Compute statistics with weights varies
weights=zeros(2,20);
for i=1:20
    weights(:,i)=[cos((i-1)*pi/20);sin((i-1)*pi/20)];
end

BERR=zeros(1,length(weights));
MNR=zeros(1,length(weights));
VAR=zeros(1,length(weights));
I2C2=zeros(1,length(weights));
    for w=1:length(weights)
    w1=weights(w);
    O_1d=O*weights(:,w);
    
    
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
    I2C2(w)=compute_i2c2(O_1d,ID);
    if Experiment==1
    BERR(w)=normcdf(abs(weights(1,w))/sqrt(4*weights(1,w)^2+weights(2,w)^2));
    end
    if Experiment==2
    BERR(w)=normcdf(abs(weights(1,w))/sqrt(weights(1,w)^2+4*weights(2,w)^2));
    end
    end

    
    
%% %%%%% Find optimal weights    
[~,index]=min(MNR);
wMNR=weights(:,index);
[~,index]=max(VAR);
wVAR=weights(:,index);
[~,index]=max(I2C2);
wI2C2=weights(:,index);
if(Experiment==1)
wBERR=weights(:,1);
end
if(Experiment==2)
wBERR=weights(:,1);
end
if(Experiment==3)
wBERR=weights(:,16);
end

%% %%%%Save data
currentdir=pwd;
lastSlashPosition = find(currentdir == '\', 1, 'last');
parentdir = currentdir(1:lastSlashPosition-1);
savedir=strcat(parentdir,strcat('\Plots\simu_fig2_2sub_data',num2str(Experiment)));
save(savedir,'O','wBERR','wMNR','wVAR','wI2C2','n','BERR','MNR');


