%%%Compute MNR, knnerr and knnmse of NKI
%%%Load D01 and NKIdemoinfo before running the script
%%%make sure compute_mnr is in the path
mrs=zeros(1,51);
for j=1:51
D=D01(:,:,j);
Ranks=zeros(1,352);
mrs(j)=compute_mnr(D,[1:176 1:176]);
end

%%%k nn gender
k=10;
knnerr=zeros(1,51);
for i=1:51
    D=D01(:,:,i);
    Pre=zeros(1,352);
    for j=1:176 
        D1=D(j,:);
        D1(j)=+Inf;
        D1(j+176)=+Inf;
        D2=D(j+176,:);
        D2(j)=+Inf;
        D2(j+176)=+Inf;
        [~,ix1]=sort(D1);
        [~,ix2]=sort(D2);
        G=[Gender(ix1(1:k)) Gender(ix2(1:k))];
        if sum(G)>k
            Pre(j)=1;
            Pre(j+176)=1;
        end
        if sum(G)<k
            Pre(j)=0;
            Pre(j+176)=0;
        end
        if sum(G)==k
            Pre(j)=round(rand(1));
            Pre(j+176)=Pre(j);
        end
    end
    knnerr(i)=sum(Pre~=Gender)/352;
end
     
%%%k nn sex
k=10;
knnmse=zeros(1,51);
for i=1:51
    D=D01(:,:,i);
    AgePre=zeros(352,1);
    for j=1:176 
        D1=D(j,:);
        D1(j)=+Inf;
        D1(j+176)=+Inf;
        D2=D(j+176,:);
        D2(j)=+Inf;
        D2(j+176)=+Inf;
        [~,ix1]=sort(D1);
        [~,ix2]=sort(D2);
        AgePre(j)=mean([Age(ix1(1:k)); Age(ix2(1:k))]);
        AgePre(j+176)=mean([Age(ix1(1:k)); Age(ix2(1:k))]);
    end
    knnmse(i)=sum((AgePre-Age).^2)/352;
end

x=(0:50)/50;
plot(x,mrs,'r*-')        
title('10nn on 165 Brain Parcels data set: MR,MSE,ClaERR (red, green, blue) vs Threshold ')
xlabel('Threshold on absolute correlation') 
ylabel('Stats') 
line('XData',x,'YData',knnerr,'LineStyle', '-','Marker','*','color','b')
line('XData',x,'YData',knnmse/15,'LineStyle', '-','Marker','*','color','g')
% line('XData',[0.2 0.2],'YData', [0 1],'color','b','LineStyle', ':','LineWidth',2)
% line('XData',[0.16 0.16],'YData', [0 1],'color','g','LineStyle', ':','LineWidth',2)
% line('XData',[0.18 0.18],'YData', [0 1],'color','r','LineStyle', ':','LineWidth',2)