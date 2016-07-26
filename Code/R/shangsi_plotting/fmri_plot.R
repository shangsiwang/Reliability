
# setwd('C:/Users/shang/Desktop/Desktop/shangsi')
# datapath<-'C:/Users/shang/Desktop/Desktop/shangsi/reliability'
# routput <- list.files(datapath, pattern="\\.RData", full.names=TRUE)
# data<-c()
# for (i in 1:11) {
# load(routput[i])
#   data<-cbind(data,mnr)
# }
###############################################
rm(list=ls())
setwd('C:/Users/shang/Desktop/Desktop/shangsi/reliability')
load('./data/rank_raw_rel.RData')
source('multiplot.R')
###############################################
pipelines<-c()

for( i in 1:64){
  pipelines<-c(pipelines,substr(datafiles[i], nchar(datafiles[i])-25+1, nchar(datafiles[i])))
}

###############################################
#####plot raw=1 rank=0 diff=3
###############################################
rawornot<-1
if(rawornot==1){
data<-matrix(rawrel,64,12)
}else if (rawornot==0){
  data<-matrix(rankrel,64,12)
} else if (rawornot==3){
  data<-matrix(rankrel-rawrel,64,12)
}

datascans<-c(100, 100, 244,  59,  50, 156,  60,  75,  59 ,159, 50 ,120)
colMax<-apply(data,2,max)
rowMean<-apply(data,1,mean)
srm<-sort(rowMean,index=T,decreasing = T)
pipelines_order<-pipelines[srm$ix]
numMethod<-nrow(data)
numExp<-ncol(data)

###all 64*numexp points plot 
###Reorder the pipelines
v<-c(c(50,58,34,42,18,26,2,10),c(50,58,34,42,18,26,2,10)+4)
plotorder<-c(v,v+2,v-1,v+1)
###Generate Plots

xmarks<-c()
for(i in 1:64){
  ithmark<-pipelines[i]
  ithmark<-gsub('ANT', 'A', ithmark)
  ithmark<-gsub('FSL', 'F', ithmark)
  ithmark<-gsub('scr', 'S', ithmark)
  ithmark<-gsub('nsc', 'X', ithmark)
  ithmark<-gsub('gsr', 'G', ithmark)
  ithmark<-gsub('ngs', 'X', ithmark)
  ithmark<-gsub('frf', 'F', ithmark)
  ithmark<-gsub('nff', 'X', ithmark)
  if(grepl('cc2',ithmark)) {ithmark<-paste('C',ithmark,sep='')}
  ithmark<-gsub('cc2', '', ithmark)
  if(grepl('hox',ithmark)) {ithmark<-paste('H',ithmark,sep='')}
  ithmark<-gsub('hox', '', ithmark)
  if(grepl('aal',ithmark)) {ithmark<-paste('A',ithmark,sep='')}
  ithmark<-gsub('aal', '', ithmark)
  if(grepl('des',ithmark)) {ithmark<-paste('D',ithmark,sep='')}
  ithmark<-gsub('des', '', ithmark)
  ithmark<-gsub('_', '', ithmark)
  ithmark<-gsub('.RData', '', ithmark)
  xmarks[i]<-ithmark
}

#################################
#####using ggplot


df<-c()
dotsize<-datascans/max(datascans)/2
dotcol<-1:numExp
for(j in 1:64) {
  df<-rbind(df,cbind(data[plotorder[j],],rep(j,numExp),rep(ceiling(j/16),numExp),dotsize,dotcol))
}

df<-as.data.frame(df)
colnames(df)<-c('rel','x','cg','sz','cl')
df$cg<-factor(df$cg)
df$cl<-factor(df$cl)

datanames<-c('BNU1','BNU2','DC1','IACAS','IBATRT','IPCAS','JHNU','NYU1','SWU1','UM','UWM','XHCUMS')
p1<-ggplot(data=df, aes(x=x, y=rel, color=cl,size=sz)) +geom_point(shape=19)+
  labs(title="Discriminability of Raw fMRI Graphs Processed 64 Ways",x='', y = "Discriminability")+
  scale_x_discrete(breaks=1:64,labels=xmarks[plotorder])+ 
  theme(axis.text.x=element_text(angle=90,size = rel(1.5),vjust=0,family = "mono"))+
  scale_color_discrete(name="Data sets",labels=datanames)+
  scale_size_continuous(name="Data sets",labels=datanames,breaks=dotsize)+
#  scale_size(guide = FALSE)+
  stat_summary(fun.y=mean, geom="point",shape=18, size=4, color="black",show.legend = F)+
  theme(text = element_text(size=15))
  #geom_hline(yintercept=0,linetype=2)
  
p1

#######################

rawornot<-3
if(rawornot==1){
  data<-matrix(rawrel,64,12)
}else if (rawornot==0){
  data<-matrix(rankrel,64,12)
} else if (rawornot==3){
  data<-matrix(rankrel-rawrel,64,12)
}

datascans<-c(100, 100, 244,  59,  50, 156,  60,  75,  59 ,159, 50 ,120)
colMax<-apply(data,2,max)
rowMean<-apply(data,1,mean)
srm<-sort(rowMean,index=T,decreasing = T)
pipelines_order<-pipelines[srm$ix]
numMethod<-nrow(data)
numExp<-ncol(data)

###all 64*numexp points plot 
###Reorder the pipelines
v<-c(c(50,58,34,42,18,26,2,10),c(50,58,34,42,18,26,2,10)+4)
plotorder<-c(v,v+2,v-1,v+1)
###Generate Plots

xmarks<-c()
for(i in 1:64){
  ithmark<-pipelines[i]
  ithmark<-gsub('ANT', 'A', ithmark)
  ithmark<-gsub('FSL', 'F', ithmark)
  ithmark<-gsub('scr', 'S', ithmark)
  ithmark<-gsub('nsc', 'X', ithmark)
  ithmark<-gsub('gsr', 'G', ithmark)
  ithmark<-gsub('ngs', 'X', ithmark)
  ithmark<-gsub('frf', 'F', ithmark)
  ithmark<-gsub('nff', 'X', ithmark)
  if(grepl('cc2',ithmark)) {ithmark<-paste('C',ithmark,sep='')}
  ithmark<-gsub('cc2', '', ithmark)
  if(grepl('hox',ithmark)) {ithmark<-paste('H',ithmark,sep='')}
  ithmark<-gsub('hox', '', ithmark)
  if(grepl('aal',ithmark)) {ithmark<-paste('A',ithmark,sep='')}
  ithmark<-gsub('aal', '', ithmark)
  if(grepl('des',ithmark)) {ithmark<-paste('D',ithmark,sep='')}
  ithmark<-gsub('des', '', ithmark)
  ithmark<-gsub('_', '', ithmark)
  ithmark<-gsub('.RData', '', ithmark)
  xmarks[i]<-ithmark
}

#################################
#####using ggplot
library(ggplot2)


df<-c()
dotsize<-datascans/max(datascans)/2
dotcol<-1:numExp
for(j in 1:64) {
  df<-rbind(df,cbind(data[plotorder[j],],rep(j,numExp),rep(ceiling(j/16),numExp),dotsize,dotcol))
}

df<-as.data.frame(df)
colnames(df)<-c('rel','x','cg','sz','cl')
df$cg<-factor(df$cg)
df$cl<-factor(df$cl)

datanames<-c('BNU1','BNU2','DC1','IACAS','IBATRT','IPCAS','JHNU','NYU1','SWU1','UM','UWM','XHCUMS')
p2<-ggplot(data=df, aes(x=x, y=rel, color=cl,size=sz)) +geom_point(shape=19)+
  labs(title="Difference in Discriminability of fMRI Graphs Processed 64 Ways",x='', y = "Discriminability")+
  scale_x_discrete(breaks=1:64,labels=xmarks[plotorder])+ 
  theme(axis.text.x=element_text(angle=90,size = rel(1.5),vjust=0,family = "mono"))+
  scale_color_discrete(name="Data sets",labels=datanames)+
  scale_size_continuous(name="Data sets",labels=datanames,breaks=dotsize)+
  #  scale_size(guide = FALSE)+
  stat_summary(fun.y=mean, geom="point",shape=18, size=4, color="black",show.legend = F)+
  theme(text = element_text(size=15))
#geom_hline(yintercept=0,linetype=2)

p2
multiplot(p1,p2,cols=1)