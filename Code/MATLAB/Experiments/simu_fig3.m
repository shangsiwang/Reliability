%% %%%%Perform simulations to show Rhat converge to true mnr

theoMnr=0.3849808;
rep=100;
nSamples=[10 20 50 100 200]; 
simuMnr=zeros(5,rep);
mMNR=zeros(1,5);
eMNR=zeros(1,5);



for k=1:length(nSamples)
    n=nSamples(k);

for iter=1:rep
    %generate 1-dimensional data 2 scans per subject
    O=randn(n,1);
    O1=O+randn(n,1);
    O2=O+randn(n,1);
    O=[O1;O2];
    
D=zeros(2*n,2*n);
for i=1:(2*n)
    for j=(i+1):(2*n)
        Dij=norm(O(i,:)-O(j,:));
        D(i,j)=Dij;
        D(j,i)=Dij;
    end
end

ID=[1:n 1:n];
simuMnr(k,iter)=compute_mnr(D,ID);
end
end

%% %%%%Save data
currentdir=pwd;
lastSlashPosition = find(currentdir == '\', 1, 'last');
parentdir = currentdir(1:lastSlashPosition-1);
savedir=strcat(parentdir,'\Plots\simu_fig3_data');
save(savedir,'simuMnr','theoMnr');
