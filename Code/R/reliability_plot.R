
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
load('Reliability_11_datasets.RData')
###############################################
datascans<-c(100,100,244,50,156,42,48,48,48,50,120)
colMax<-apply(data,2,max)
rowMean<-apply(data,1,mean)
srm<-sort(rowMean,index=T,decreasing = T)
pipelines_order<-pipelines[srm$ix]
numMethod<-nrow(data)
numExp<-ncol(data)

###all 64*numexp points plot 
###Reorder the pipelines
v<-c(c(57,49,41,33,25,17,9,1),c(57,49,41,33,25,17,9,1)+4)
plotorder<-c(v+1,v+2,v,v+3)
###Generate Plots
# par(mar=c(7,4,4,2))
# plot(NULL, xlim=c(0,65), ylim=c(0.6,1), ylab="Reliability", xlab="",axes=F,main='Reliability of 64 Pipelines')
# 
# for(j in 1:16) {
# points(rep(j,numExp),data[plotorder[j],],col=101,pch = 19,cex=0.6)
#  }
# for(j in 17:32) {
#   points(rep(j,numExp),data[plotorder[j],],col=102,pch = 19,cex=0.6)
# }
# for(j in 33:48) {
#   points(rep(j,numExp),data[plotorder[j],],col=103,pch = 19,cex=0.6)
# }
# for(j in 49:64) {
#   points(rep(j,numExp),data[plotorder[j],],col=104,pch = 19,cex=0.6)
# }
# 
# axis(2)
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
  xmarks[i]<-ithmark
}
# axis(1,at=1:64,labels=xmarks[plotorder],las=2)
# legend(x=59,y=1,legend=c('CC2', 'HOX', 'AAL','DES'), pch = c(19,19,19,19),col = 101:104, cex = c(0.7))
# dev.off()
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

datanames<-c('BNU1','BNU2','DC1','IBATRT','IPCAS','KKI21','NKI24mx645','NKI24mx1400','NKIstd2500','UWM','XHCUMS')
p<-ggplot(data=df, aes(x=x, y=rel, color=cl,size=sz)) +geom_point(shape=19)+
  labs(title="Reliability of 64 Pipelines",x='', y = "Reliability")+
  scale_x_discrete(breaks=1:64,labels=xmarks[plotorder])+ 
  theme(axis.text.x=element_text(angle=90,size = rel(1.5),vjust=0,family = "mono"))+
  scale_color_discrete(name="Atlases",labels=datanames)+
  scale_size(guide = FALSE)+
  stat_summary(fun.y=mean, geom="point",shape=18, size=4, color="black",show.legend = F)
p
  