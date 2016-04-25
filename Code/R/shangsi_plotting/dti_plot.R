# rm(list=ls())
# fpath<-"C:/Users/shang/Desktop/Desktop/shangsi/reliability/DTI/"
# datanames<-list.files(path = fpath)
# 
# 
# rois<-c()
# rel<-c()
# for(i in 1:(length(datanames)/2)){
#   if(i==15) next
#   load(paste(fpath,datanames[2*i-1],sep=''))
#   rois[i]<-dim(pack[[1]])[1]
#   rm(list='pack')
#   load(paste(fpath,datanames[2*i],sep=''))
#   rel[i]<-mnr
# }
# datanames<-datanames[1:(length(datanames)/2)*2]
# save(datanames,rel,rois,file='dti_rel_roi.RData')
#load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/dti_rel_roi.RData")
#load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/dti_rank_log_rel.RData")
rm(list=ls())
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


df<-cbind(rel,rois,rep(1,length(rel)),1:18)
df<-rbind(df,cbind(rankrel,rois,rep(2,length(rel)),1:18))
df<-rbind(df,cbind(logrel,rois,rep(3,length(rel)),1:18))
df<-as.data.frame(df)
colnames(df)[3]<-'col'
colnames(df)[4]<-'x'
df$col<-factor(df$col)

for(i in 1:length(datanames)){
  tmp<-strsplit(datanames[i],'_')
  datanames[i]<-paste(tmp[[1]][2],rois[i],sep='_')
  tmp<-strsplit(datanames[i],'/')
  datanames[i]<-tmp[[1]][2]
}




library(ggplot2)
p<-ggplot(data=df, aes(x=rois, y=rel,col=col)) +geom_point(shape=19,size=3)+
  labs(title="Discriminability of SWU4 DTI with 0.5% Scans Removed",x='Log(ROI)', y = "Discriminability")+
  theme(axis.text.x=element_text(angle=90,size = rel(1.5),vjust=0,family = "mono"))+
  scale_colour_discrete(name="Method",breaks=c(1,2,3), labels=c("Raw", "Rank","Log"))

p
