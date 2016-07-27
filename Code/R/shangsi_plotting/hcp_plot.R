###Plot for HCP 100
rm(list=ls())
library(ggplot2)


load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/HCP100_461_k5_Result.RData")

k=6
ageerr<-ageerr
neoerr<-neoerr
gendererr<-gendererr
iicc[is.na(iicc)]<-0
sageerr<-(ageerr-min(ageerr))/(max(ageerr)-min(ageerr))*0.5+0.3
aneoerr<-rowMeans(neoerr)
sneoerr<-(aneoerr-min(aneoerr))/(max(aneoerr)-min(aneoerr))*0.5+0.3
iicc<-iicc+0.5

df<-cbind((0:50)/50,rel,rep(1,51))
df<-rbind(df,cbind((0:50)/50,gendererr,rep(2,51)))
df<-rbind(df,cbind((0:50)/50,sageerr,rep(3,51)))
df<-rbind(df,cbind((0:50)/50,sneoerr,rep(4,51)))
df<-rbind(df,cbind((0:50)/50,iicc,rep(5,51)))

ind1<-which(rel==max(rel))
ind2<-which(gendererr==min(gendererr))
ind3<-which(ageerr==min(ageerr))
ind4<-which(sneoerr==min(sneoerr))
ind5<-which(iicc==max(iicc))

df<-as.data.frame(df)
colnames(df)<-c('t','stat','col')
df$col<-factor(df$col)

gg_color_hue <- function(n) {
  hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
cols = gg_color_hue(5)

p<-ggplot(data=df, aes(x=t, y=stat,group=col,col=col)) +geom_line(size=1.5)+
  labs(title="HCP100 Discriminability and Prediction Results", y = "Statistics",x='Threshold')+
  scale_colour_discrete(name="Statistic",breaks=c(1,2,3,4,5), labels=c("Dis", "Sex","Age","Neo","I2C2"))+
  geom_vline(xintercept=c(ind1,ind2,ind3,ind4,ind5)*0.02-0.02,size=1,linetype=2,col=c( "#F8766D", "#A3A500", "#00BF7D", "#00B0F6", "#E76BF3"))+
  geom_point(x=ind1*0.02-0.02,y=rel[ind1],col="#F8766D",size=5)+
  geom_point(x=ind2*0.02-0.02,y=gendererr[ind2],col="#A3A500",size=5)+
  geom_point(x=ind3*0.02-0.02,y=sageerr[ind3],col="#00BF7D",size=5)+
  geom_point(x=ind4*0.02-0.02,y=sneoerr[ind4],col="#00B0F6",size=5)+
  geom_point(x=ind5*0.02-0.02,y=iicc[ind5],col="#E76BF3",size=5)+
  theme(text = element_text(size=15))
p
#ggsave(paste("hcp_",as.character(k),".png",sep=""))
