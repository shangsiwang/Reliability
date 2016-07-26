#####################################################
####rank log raw plot
#####load SWU4
rm(list=ls())
source('multiplot.R')
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/BNU1_dti_rank_log_rel.RData")
rois<-c(116,200 ,70 , 70  , 95 ,107 ,139,194,277,349, 445,582,832,1215,1875, 111 , 48,1105)
roiorder<-sort(rois,index=T)
datanames<-datanames[roiorder$ix]
rois<-rois[roiorder$ix]
rel<-rel[roiorder$ix]
rankrel<-rankrel[roiorder$ix]
logrel<-logrel[roiorder$ix]
####use log roi
sigma<-0.1
rois<-log(rois)
df<-cbind(rel,rois+rnorm(18,0,sigma),rep(1,length(rel)),1:18)
df<-rbind(df,cbind(rankrel,rois+rnorm(18,0,sigma),rep(2,length(rel)),1:18))
df<-rbind(df,cbind(logrel,rois+rnorm(18,0,sigma),rep(3,length(rel)),1:18))
dff<-cbind(df,rep(1,18))

#####load BNU1
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/HNU1_dti_rank_log_rel.RData")
rois<-c(116,200 ,70 , 70  , 95 ,107 ,139,194,277,349, 445,582,832,1215,1875, 111 , 48,1105)
roiorder<-sort(rois,index=T)
datanames<-datanames[roiorder$ix]
rois<-rois[roiorder$ix]
rel<-rel[roiorder$ix]
rankrel<-rankrel[roiorder$ix]
logrel<-logrel[roiorder$ix]
####use log roi
rois<-log(rois)
df<-cbind(rel,rois+rnorm(18,0,sigma),rep(1,length(rel)),1:18)
df<-rbind(df,cbind(rankrel,rois+rnorm(18,0,sigma),rep(2,length(rel)),1:18))
df<-rbind(df,cbind(logrel,rois+rnorm(18,0,sigma),rep(3,length(rel)),1:18))
df<-cbind(df,rep(2,18))
dff<-rbind(dff,df)

#####load KKI
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/SWU4_dti_rank_log_rel.RData")
rois<-c(116,200 ,70 , 70  , 95 ,107 ,139,194,277,349, 445,582,832,1215,1875, 111 , 48,1105)
roiorder<-sort(rois,index=T)
datanames<-datanames[roiorder$ix]
rois<-rois[roiorder$ix]
rel<-rel[roiorder$ix]
rankrel<-rankrel[roiorder$ix]
logrel<-logrel[roiorder$ix]
####use log roi
rois<-log(rois)
df<-cbind(rel,rois+rnorm(18,0,sigma),rep(1,length(rel)),1:18)
df<-rbind(df,cbind(rankrel,rois+rnorm(18,0,sigma),rep(2,length(rel)),1:18))
df<-rbind(df,cbind(logrel,rois+rnorm(18,0,sigma),rep(3,length(rel)),1:18))
df<-cbind(df,rep(3,18))
dff<-rbind(dff,df)

#####load HNU1
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/KKI2009_dti_rank_log_rel.RData")
rois<-c(116,200 ,70 , 70  , 95 ,107 ,139,194,277,349, 445,582,832,1215,1875, 111 , 48,1105)
roiorder<-sort(rois,index=T)
datanames<-datanames[roiorder$ix]
rois<-rois[roiorder$ix]
rel<-rel[roiorder$ix]
rankrel<-rankrel[roiorder$ix]
logrel<-logrel[roiorder$ix]
####use log roi
rois<-log(rois)
df<-cbind(rel,rois+rnorm(18,0,sigma),rep(1,length(rel)),1:18)
df<-rbind(df,cbind(rankrel,rois+rnorm(18,0,sigma),rep(2,length(rel)),1:18))
df<-rbind(df,cbind(logrel,rois+rnorm(18,0,sigma),rep(3,length(rel)),1:18))
df<-cbind(df,rep(4,18))
dff<-rbind(dff,df)

df<-dff
#####
df<-as.data.frame(df)
colnames(df)[2]<-'rois'
colnames(df)[3]<-'col'
colnames(df)[4]<-'x'
colnames(df)[5]<-'data'
df$col<-factor(df$col)
df$data<-factor(df$data)

for(i in 1:length(datanames)){
  tmp<-strsplit(datanames[i],'_')
  datanames[i]<-paste(tmp[[1]][2],rois[i],sep='_')
  tmp<-strsplit(datanames[i],'/')
  datanames[i]<-tmp[[1]][2]
}


####
library(ggplot2)
p1<-ggplot(data=df, aes(x=rois, y=rel,col=col,shape=data)) +geom_point(size=3)+
  labs(title="Discriminability of Four DTI Data Sets",x='Log(ROI)', y = "Discriminability")+
  scale_color_discrete(name="Method",breaks=c(1,2,3), labels=c("Raw", "Rank","Log"))+
  scale_shape_discrete(name="Data set",breaks=c(1,2,3,4), labels=c("BNU1", "HNU1","SWU4","KKI"))+
  theme(text = element_text(size=15))

p1



#####################################################
#### dti fmri comparison plot
dti_rel<-c()
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/BNU1_dti_rank_log_rel.RData")
dti_rel<-c(dti_rel,rel[c(2,16,1,3)])
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/HNU1_dti_rank_log_rel.RData")
dti_rel<-c(dti_rel,rel[c(2,16,1,3)])
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/SWU4_dti_rank_log_rel.RData")
dti_rel<-c(dti_rel,rel[c(2,16,1,3)])
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/KKI2009_dti_rank_log_rel.RData")
dti_rel<-c(dti_rel,rel[c(2,16,1,3)])

mri_rel<-c()
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/MRI/BNU1_fmri_rel.RData")
mri_rel<-c(mri_rel,rel[c(2,4,1,3)])
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/MRI/HNU1_fmri_rel.RData")
mri_rel<-c(mri_rel,rel[c(2,4,1,3)])
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/MRI/SWU4_fmri_rel.RData")
mri_rel<-c(mri_rel,rel[c(2,4,1,3)])
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/MRI/KKI2009_fmri_rel.RData")
mri_rel<-c(mri_rel,rel[c(2,4,1,3)])


gitter<-c(rep(1,4)+rnorm(4,0,0.1),rep(2,4)+rnorm(4,0,0.1),rep(3,4)+rnorm(4,0,0.1),rep(4,4)+rnorm(4,0,0.1))
gitter<-c(gitter)
df<-cbind(c(dti_rel-mri_rel),gitter,rep(1:4,4))
df<-as.data.frame(df)
colnames(df)[3]<-'col'
colnames(df)[2]<-'x'
colnames(df)[1]<-'rel'
df$col<-factor(df$col)


p2<-ggplot(data=df, aes(x=x, y=rel,col=col)) +geom_point(shape=19,size=3)+
  labs(title="Discriminability difference between DTI and fMRI", y = "Discriminability Difference",x='Data Set')+
  scale_x_continuous(breaks=1:4,labels=c("BNU1","HNU1","SWU4","KKI"),limits = c(0.5, 4.5))+ 
  scale_colour_discrete(name="Atlas",breaks=c(1,2,3,4), labels=c("CC2", "HOX","AAL","DES"))+
  geom_hline(yintercept=0,linetype=2)+
  annotate("text", x = 1:4, y = 0.15, label = c("29%","11%","0.5%","0%"),size=4)+
  theme(text = element_text(size=15))
p2











#####################################################
###plot dti under different exp design
library(ggplot2)

files<-list.files(path = "C:/Users/shang/Desktop/Desktop/shangsi/reliability/data", pattern = "dti_rank_log_rel.RData", full.names=T)

dtirel<-c()

for (i in 1:(length(files)-2)){
  load(files[i])
  dtirel<-c(dtirel,rel[c(2,16,1,3)])
}

gitter<-c(rep(1,4)+rnorm(4,0,0.1),rep(3,4)+rnorm(4,0,0.1),rep(2,4)+rnorm(4,0,0.1),rep(4,4)+rnorm(4,0,0.1))
gitter<-c(gitter)
sz<-c(81,81,81,81,266,266,266,266,38,38,38,38,42,42,42,42)/100
df<-cbind(dtirel,gitter,rep(1:4,4),sz)
df<-as.data.frame(df)
colnames(df)[4]<-'sz'
colnames(df)[3]<-'col'
colnames(df)[2]<-'x'
colnames(df)[1]<-'rel'
df$col<-factor(df$col)


p3<-ggplot(data=df, aes(x=x, y=rel,col=col,size=sz)) +geom_point(shape=19)+  scale_size_area(guide=FALSE)+
  labs(title="Discriminability of four data sets with different number of directions", y = "Discriminability",x='Data set and number of directions')+
  scale_x_continuous(breaks=1:4,labels=c("BNU1-30","KKI-32","HNU1-33","NKI1-137"))+ 
  scale_colour_discrete(name="Atlas",breaks=c(1,2,3,4), labels=c("CC2", "HOX","AAL","DES"))+
  theme(text = element_text(size=15))
p3

####
df<-df[c(1:4,9:16),]
df[,2]<-c(rep(1,4)+rnorm(4,0,0.1),rep(2,4)+rnorm(4,0,0.1),rep(3,4)+rnorm(4,0,0.1))
p4<-ggplot(data=df, aes(x=x, y=rel,col=col,size=sz)) +geom_point(shape=19)+scale_size_area(guide=FALSE)+
  labs(title="Discriminability of three data sets with different b-values", y = "Discriminability",x='Data set and b-value')+
  scale_x_continuous(breaks=1:3,labels=c("BNU1-1000","KKI-700","NKI1-1500"))+ 
  scale_colour_discrete(name="Atlas",breaks=c(1,2,3,4), labels=c("CC2", "HOX","AAL","DES"))+
  theme(text = element_text(size=15))
p4

multiplot(p1,p2,p3,p4,cols=2)
