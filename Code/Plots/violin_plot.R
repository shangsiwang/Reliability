###############################################
rm(list=ls())
setwd('C:/Users/shang/Desktop/Desktop/shangsi/reliability')
load('Reliability_11_datasets.RData')
###############################################
library(ggplot2)
nfile<-ncol(data)
df<-c(nff-frf, fsl-ant,nsc-scr,gsr-ngs)
gi<-c(rep(1,nfile*32),rep(2,nfile*32),rep(3,nfile*32),rep(4,nfile*32))
ndf<-c(df,-df)
df<-cbind(df,2*gi-1,gi)
df<-rbind(df,cbind(ndf,2*c(gi,gi),rep(5,2*length(gi))))
df<-as.data.frame(df)

colnames(df)<-c('df','dec','cg')
df$dec<-as.factor(df$dec)
df$cg<-as.factor(df$cg)
p<-ggplot(data=df,aes(x=dec, y=df,fill=cg))+geom_violin(trim=T)+
  labs(title="Plot of Diffenrence in Reliability",x="Decisions Compared", y = "Difference")+
  scale_x_discrete(breaks=c("1", "3", "5",'7'),
                   labels=c('nff - frf', 'fsl - ant','nsc - scr','gsr - ngs')) +
  scale_fill_manual(name="Decisions",
                    breaks = c("1", "2", "3",'4','5'), 
                    values=c("#F8766D", "#7CAE00", "#00BFC4", "#C77CFF","grey"),
                    labels=c('nff - frf', 'fsl - ant','nsc - scr','gsr - ngs','Null Distribution'))
p 

###############################################
#Overlay violin plot, not finished
###############################################
df<-c(nff-frf, fsl-ant,nsc-scr,gsr-ngs)
gi<-c(rep(1,nfile*32),rep(2,nfile*32),rep(3,nfile*32),rep(4,nfile*32))
ndf<-c(df,-df)
tdf<-c(df,df)
df<-cbind(tdf,ndf,c(gi,gi),c(gi,gi))

df<-as.data.frame(df)
colnames(df)<-c('df','ndf','dec','cg')
df$dec<-as.factor(df$dec)
df$cg<-as.factor(df$cg)

p<-ggplot(data=df,aes(x=dec, y=df,colour=cg))+
  geom_violin(trim=T)+ 
  geom_violin(aes(y = ndf,colour="grey"),trim=T)+
  labs(title="Plot of Diffenrence in Reliability",x="Decisions Compared", y = "Difference")
p 
