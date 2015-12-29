###############################################
rm(list=ls())
setwd('C:/Users/shang/Desktop/Desktop/shangsi/reliability')
load('Reliability_11_datasets.RData')
###############################################
###Atlas analysis
value1<-c()
value2<-c()
value3<-c()
value4<-c()
for(i in 1:64){
  if(grepl( 'hox',pipelines[i])){
    value1<-c(value1,data[i,])
    pairpipe<-gsub('hox', 'cc2', pipelines[i])
    for(j in 1:64){
      if(grepl(pairpipe,pipelines[j])){
        value2<-c(value2,data[j,])
      }
    }
    pairpipe<-gsub('hox', 'aal', pipelines[i])
    for(j in 1:64){
      if(grepl(pairpipe,pipelines[j])){
        value3<-c(value3,data[j,])
      }
    }
    pairpipe<-gsub('hox', 'des', pipelines[i])
    for(j in 1:64){
      if(grepl(pairpipe,pipelines[j])){
        value4<-c(value4,data[j,])
      }
    }
  }
}

# valueall<-cbind(value1,value2,value3,value4)
# hox<-value1
# cc2<-value2
# aal<-value3
# des<-value4
# 
# valueall<-t(valueall)
colMax<-apply(data,2,max)
numMethod<-nrow(data)
numExp<-ncol(data)
t<-(0:100)/100
perfPro<-matrix(0,numMethod,101)

for (j in 1:numMethod) {
  for(i in 1:101) {
    perfPro[j,i]=sum(data[j,]>=colMax-t[i]/3)/numExp
  }
}

df<-c()
colorvec<-c()
for( i in 1:numMethod) {
  
  if(grepl( 'cc2',pipelines[i])){
    colorvec[i]<-1
  }
  if(grepl( 'hox',pipelines[i])){
    colorvec[i]<-2
  }
  if(grepl( 'aal',pipelines[i])){
    colorvec[i]<-3
  }
  if(grepl( 'des',pipelines[i])){
    colorvec[i]<-4
  }
  df<-rbind(df,cbind(perfPro[i,],rep(i,101),t/3,rep(colorvec[i],101)))
}
df<-as.data.frame(df)
colnames(df)<-c('perc','g','t','cg')
df$g<-factor(df$g)
df$cg<-factor(df$cg)

p<-ggplot(data=df, aes(x=t, y=perc, group=g,color=cg)) +geom_line(size=1) +
  labs(title="Performance Profile of 4 Atlases",x="Difference Between the Best", y = "Percentage")+
  scale_color_discrete(name="Atlases",
                       breaks=c("1", "2", "3",'4'),
                       labels=c('cc2', 'hox','aal','des'))
p
