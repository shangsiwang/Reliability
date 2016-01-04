
# setwd('C:/Users/shang/Desktop/Desktop/shangsi')
# datapath<-'C:/Users/shang/Desktop/Desktop/shangsi/reliability'
# routput <- list.files(datapath, pattern="\\.RData", full.names=TRUE)
# data<-c()
# for (i in 1:12) {
# load(routput[i])
#   data<-cbind(data,mnr)
# }
###############################################
rm(list=ls())
load('Reliability_11_datasets.RData')
###############################################
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
par(mar=c(7,4,4,2))
plot(NULL, xlim=c(0,65), ylim=c(0.6,1), ylab="Reliability", xlab="",axes=F,main='Reliability of 64 Pipelines')

for(j in 1:16) {
points(rep(j,numExp),data[plotorder[j],],col=101,pch = 19,cex=0.6)
 }
for(j in 17:32) {
  points(rep(j,numExp),data[plotorder[j],],col=102,pch = 19,cex=0.6)
}
for(j in 33:48) {
  points(rep(j,numExp),data[plotorder[j],],col=103,pch = 19,cex=0.6)
}
for(j in 49:64) {
  points(rep(j,numExp),data[plotorder[j],],col=104,pch = 19,cex=0.6)
}

axis(2)
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
  ithmark<-gsub('cc2', '', ithmark)
  ithmark<-gsub('hox', '', ithmark)
  ithmark<-gsub('aal', '', ithmark)
  ithmark<-gsub('des', '', ithmark)
  ithmark<-gsub('_', '', ithmark)
  xmarks[i]<-ithmark
}
axis(1,at=1:64,labels=xmarks[plotorder],las=2)
legend(x=59,y=1,legend=c('CC2', 'HOX', 'AAL','DES'), pch = c(19,19,19,19),col = 101:104, cex = c(0.7))
# dev.off()
# 
# jitterf<-function(t){runif(1,t-0.25,t+0.25)}
# 
# 
# ###
# plot(NULL, xlim=c(0,5), ylim=c(0.5,1), ylab="Reliability", xlab="",axes=F,main='Reliability of 4 Atlas')
# for(i in 1:numMethod){
# for(j in 1:numExp) {
#   if(grepl( 'aal',pipelines[i])){
#   points(jitterf(1),data[i,j],col=101,pch = 19,cex=0.5)
#   }
#   if(grepl('cc2',pipelines[i])){
#     points(jitterf(2),data[i,j],col=102,pch = 19,cex=0.5)
#   }
#   if(grepl( 'hox',pipelines[i])){
#     points(jitterf(3),data[i,j],col=101,pch = 19,cex=0.5)
#   }
#   if(grepl('des',pipelines[i])){
#     points(jitterf(4),data[i,j],col=101,pch = 19,cex=0.5)
#   }
# }
# }
# 
# axis(2)
# axis(1,at=1:4,labels=c('aal','cc2','hox','des'),las=2)
# 
# 
# ###
# plot(NULL, xlim=c(0,3), ylim=c(0.5,1), ylab="Reliability", xlab="",axes=F,main='Reliability of nff vs frf')
# for(i in 1:numMethod){
#   for(j in 1:numExp) {
#     if(grepl( 'nff',pipelines[i])){
#       points(jitterf(1),data[i,j],col=102,pch = 19,cex=0.5)
#     }
#     if(grepl('frf',pipelines[i])){
#       points(jitterf(2),data[i,j],col=101,pch = 19,cex=0.5)
#     }
#   }
# }
# 
# axis(2)
# axis(1,at=1:2,labels=c('nff','frf'),las=2)
# 
# 
# ###
# value1<-0
# value2<-0
# plot(NULL, xlim=c(0,3), ylim=c(0.5,1), ylab="Reliability", xlab="",axes=F,main='Reliability of scr vs nsc')
# for(i in 1:numMethod){
#   for(j in 1:numExp) {
#     if(grepl( 'scr',pipelines[i])){
#       points(jitterf(1),data[i,j],col=101,pch = 19,cex=0.5)
#       value1<-value1+data[i,j]
#     }
#     if(grepl('nsc',pipelines[i])){
#       points(jitterf(2),data[i,j],col=102,pch = 19,cex=0.5)
#       value2<-value2+data[i,j]
#     }
#   }
# }
# 
# axis(2)
# axis(1,at=1:2,labels=c('scr','nsc'),las=2)
# 
# ###
# value1<-0
# value2<-0
# plot(NULL, xlim=c(0,3), ylim=c(0.5,1), ylab="Reliability", xlab="",axes=F,main='Reliability of gsr vs ngs')
# for(i in 1:numMethod){
#   for(j in 1:numExp) {
#     if(grepl( 'gsr',pipelines[i])){
#       points(jitterf(1),data[i,j],col=102,pch = 19,cex=0.5)
#       value1<-value1+data[i,j]
#     }
#     if(grepl('ngs',pipelines[i])){
#       points(jitterf(2),data[i,j],col=101,pch = 19,cex=0.5)
#       value2<-value2+data[i,j]
#     }
#   }
# }
# 
# axis(2)
# axis(1,at=1:2,labels=c('gsr','ngs'),las=2)
# 
# ###
# value1<-0
# value2<-0
# plot(NULL, xlim=c(0,3), ylim=c(0.5,1), ylab="Reliability", xlab="",axes=F,main='Reliability of ANT vs FSL')
# for(i in 1:numMethod){
#   for(j in 1:numExp) {
#     if(grepl( 'ANT',pipelines[i])){
#       points(jitterf(1),data[i,j],col=101,pch = 19,cex=0.5)
#       value1<-value1+data[i,j]
#     }
#     if(grepl('FSL',pipelines[i])){
#       points(jitterf(2),data[i,j],col=102,pch = 19,cex=0.5)
#       value2<-value2+data[i,j]
#     }
#   }
# }
# 
# axis(2)
# axis(1,at=1:2,labels=c('ANT', 'FSL'),las=2)
