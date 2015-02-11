%The function computes i2c2 for data
%DATA should be an n*p matrix where each row correspond to a sample
%ID should be a vector of length n representing subject of samples
function [ I2C2 ] = compute_i2c2(DATA,ID)
[n,p]=size(DATA);
kw=zeros(1,p);
ku=zeros(1,p);
wave=mean(DATA,1);
count=0;
id=unique(ID);
for i=id
        ind=find(ID==i);
        wsubave=mean(DATA(ind,:),1);
        count=count+1;
        for j=ind
            ku=(DATA(j,:)-wsubave).^2+ku;
            kw=(DATA(j,:)-wave).^2+kw;
        end           
end
I2C2=1-sum(ku/(n-count))/sum(kw/(n-1));
end

