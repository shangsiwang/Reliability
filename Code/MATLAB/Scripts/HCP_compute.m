%%%Compute MNR, knnerr and knnmse of HCP
%%%Load D01 and HCPdemoinfo before running the script
%%%make sure compute_mnr is in the path

%%%%%%mrs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mrs=zeros(1,51);
for j=1:51
    Ranks=zeros(1,1844*3);   
    ID=floor((4:1847)/4);
    mrs(j)=compute_mnr(D01(:,:,j),ID);
end

%%%%%%knn errs/mses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=5;
knnerr=zeros(1,51);
knnmse=zeros(1,51);
knnneo=zeros(5,51);
for j=1:51
    D=D01(:,:,j);
    Pre=zeros(461,1);
    Apre=zeros(461,1);
    Npre=zeros(461,5);
for subject=1:461
    D((subject*4-3):(subject*4),(subject*4-3):(subject*4))=+Inf;
    [~,ix1]=sort(D(4*subject,:));
    [~,ix2]=sort(D(4*subject-1,:));
    [~,ix3]=sort(D(4*subject-2,:));
    [~,ix4]=sort(D(4*subject-3,:));
    IX1=find(D(4*subject,:)==D(4*subject,ix1(1)));
    if(length(IX1)>=k)
        indices=randperm(length(IX1));
        ix1=IX1(indices(1:k));
    end
    IX2=find(D(4*subject-1,:)==D(4*subject-1,ix2(1)));
    if(length(IX2)>=k)
        indices=randperm(length(IX2));
        ix2=IX2(indices(1:k));
    end
     IX3=find(D(4*subject-2,:)==D(4*subject-2,ix3(1)));
    if(length(IX3)>=k)
        indices=randperm(length(IX3));
        ix3=IX3(indices(1:k));
    end
     IX4=find(D(4*subject-3,:)==D(4*subject-3,ix4(1)));
    if(length(IX4)>=k)
        indices=randperm(length(IX4));
        ix4=IX4(indices(1:k));
    end
    ix1=ceil(ix1(1:k)/4);
    ix2=ceil(ix2(1:k)/4);
    ix3=ceil(ix3(1:k)/4);
    ix4=ceil(ix4(1:k)/4);
    G=[Gender(ix1); Gender(ix2); Gender(ix3); Gender(ix4)];
    A=[Age(ix1); Age(ix2); Age(ix3); Age(ix4)];
    N=[Neo(ix1,:) ;Neo(ix2,:) ;Neo(ix3,:) ;Neo(ix4,:) ];
    Npre(subject,:)=mean(N,1);
    Apre(subject)=mean(A);
    if sum(G)>2*k
            Pre(subject)=1;
    end
    if sum(G)<2*k
            Pre(subject)=0;
    end
    if sum(G)==2*k
            Pre(subject)=round(rand(1));
    end
end
knnerr(j)=sum(Pre~=Gender)/461;
knnmse(j)=sum((Age-Apre).^2)/461;
knnneo(:,j)=sum((Neo-Npre).^2,1)/461;
end


%%%%%%%%%%%%%%%%%%%%%%%%%Plot%%%%%
th=(0:50)/50;
x=th;
plot(x,mrs,'r*-')        
title('5nn on HCP500 300 Brain Parcels data set: MR,ClaERR, MSE(red, blue, green) vs Threshold ')
xlabel('Threshold on absolute correlation') 
ylabel('Stats') 
line('XData',x,'YData',knnerr,'LineStyle', '-','Marker','*','color','b')
line('XData',x,'YData',knnmse/20,'LineStyle', '-','Marker','*','color','g')
% line('XData',[0.2 0.2],'YData', [0 1],'color','b','LineStyle', ':','LineWidth',2)
% line('XData',[0.14 0.14],'YData', [0 1],'color','g','LineStyle', ':','LineWidth',2)
% line('XData',[0.18 0.18],'YData', [0 1],'color','r','LineStyle',
% ':','LineWidth',2)