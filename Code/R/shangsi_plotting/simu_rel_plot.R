###plot for optimal projection
library(ggplot2)
rm(list=ls())
load("C:/Users/shang/Desktop/Desktop/shangsi/reliability/data/opt_proj.RData")
source('multiplot.R')
source('reliability.R')

df1<-cbind(O1,c(rep(1,400),rep(2,400)))
df1<-as.data.frame(df1)
colnames(df1)<-c('x','y','cg')
df1$cg<-factor(df1$cg)

p1<-ggplot(data=df1, aes(x=x,y=y,col=cg))+geom_point()+
  theme(legend.position="none")+xlim(-8,8)+ylim(-8,8)+
  labs(title="Scatter Plot of Samples",x="", y = "")+
  theme(text = element_text(size=15))

ind<-which(rels1==max(rels1))
theta<-(ind-1)*pi/12
O1d<-O1[,1]*cos(theta)+O1[,2]*sin(theta)
df3<-cbind(O1d,c(rep(1,400),rep(2,400)))
df3<-as.data.frame(df3)
colnames(df3)<-c('x','cg')
df3$cg<-factor(df3$cg)

p3<-ggplot(df3, aes(x, fill = cg, colour = cg)) +
  geom_density(alpha = 0.5)+
  theme(legend.position="none")+
  labs(title="Density Plot of Projection Based on Discriminability",x="", y = "")+
  theme(text = element_text(size=15))



ind<-which(vars1==max(vars1))
theta<-(ind-1)*pi/12
O1d<-O1[,1]*cos(theta)+O1[,2]*sin(theta)
df5<-cbind(O1d,c(rep(1,400),rep(2,400)))
df5<-as.data.frame(df5)
colnames(df5)<-c('x','cg')
df5$cg<-factor(df5$cg)

p5<-ggplot(df5, aes(x, fill = cg, colour = cg)) +
  geom_density(alpha = 0.5)+
  theme(legend.position="none")+
  labs(title="ODensity Plot of Projection Based on Principal Component",x="", y = "")+
  theme(text = element_text(size=15))








df2<-cbind(O2,c(rep(1,400),rep(2,400)))
df2<-as.data.frame(df2)
colnames(df2)<-c('x','y','cg')
df2$cg<-factor(df2$cg)




p2<-ggplot(data=df2, aes(x=x,y=y,col=cg))+geom_point()+
  theme(legend.position="none")+xlim(-8,8)+ylim(-8,8)+
  labs(title="Scatter Plot of Samples",x="", y = "")+
  theme(text = element_text(size=15))

ind<-which(rels2==max(rels2))
theta<-(ind-1)*pi/12
O1d<-O2[,1]*cos(theta)+O2[,2]*sin(theta)
df4<-cbind(O1d,c(rep(1,400),rep(2,400)))
df4<-as.data.frame(df4)
colnames(df4)<-c('x','cg')
df4$cg<-factor(df3$cg)

p4<-ggplot(df4, aes(x, fill = cg, colour = cg)) +
  geom_density(alpha = 0.5)+
  theme(legend.position="none")+
  labs(title="Density Plot of Projection Based on Discriminability",x="", y = "")+
  theme(text = element_text(size=15))



ind<-which(vars2==max(vars2))
theta<-(ind-1)*pi/12
O1d<-O2[,1]*cos(theta)+O2[,2]*sin(theta)
df6<-cbind(O1d,c(rep(1,400),rep(2,400)))
df6<-as.data.frame(df6)
colnames(df6)<-c('x','cg')
df6$cg<-factor(df6$cg)

p6<-ggplot(df6, aes(x, fill = cg, colour = cg)) +
  geom_density(alpha = 0.5)+
  theme(legend.position="none")+
  labs(title="Density Plot of Projection Based on Principal Component",x="", y = "")+
  theme(text = element_text(size=15))



############################################### conv plot
rep=100;
nsamples=c(10, 20, 50, 100, 200); 
df<-c()
dfm<-c()
for (i in 1:length(nsamples)){
  for (j in 1:rep){
    ns<-nsamples[i]
    X<-rnorm(ns)
    O<-c(X+rnorm(ns),X+rnorm(ns))
    pwdist<-as.matrix(dist(O,diag = T, upper = T))
    ids<-c(1:ns,1:ns)
    ids<-ids+1000
    rd<-rdf(pwdist, ids)
    df<-rbind(df,c(mean(rd),i))
  }
  dfm<-c(dfm,mean(df[(i*100-99):(i*100),1]))
}

df<-as.data.frame(df)
colnames(df)<-c('df','cg')
df$cg<-as.factor(df$cg)


df2<-as.data.frame(rbind(cbind(rep(0.61502,5),1:5,1),cbind(dfm,1:5,2)))
colnames(df2)<-c('df','cg','col')
df2$cg<-as.factor(df2$cg)
df2$col<-as.factor(df2$col)

p<-ggplot(data=df,aes(x=cg, y=df))+geom_violin(trim=T,fill="#0072B2",adjust = 2)+
  labs(title="Convergence of Discriminability Estimates",x="Sample size", y = "Discriminability")+
  scale_x_discrete(breaks=c("1", "2", "3",'4','5'),labels=c('10', '20','50','100','200')) +
  geom_point(data=df2, aes(x = cg, y = df, col = col,shape=col),size=4) +
  theme(legend.position="none")
p


df3<-df
colnames(df3)<-c('df','cg')
df3$cg<-as.factor(df3$cg)
df3$df<-df3$df-0.61502


p<-ggplot(data=df3,aes(x=cg, y=df))+geom_violin(trim=T,fill = "grey80", colour = "#3366FF",adjust = 1.5)+
  labs(title="Distribution of Difference Between Estimates and Truth",x="Sample size", y = "Difference")+
  scale_x_discrete(breaks=c("1", "2", "3",'4','5'),labels=c('10', '20','50','100','200'))+
  geom_hline(yintercept=0,linetype=2)+
  stat_summary(fun.y = "mean", colour = "red", size = 4, geom = "point")+
  theme(text = element_text(size=15))
p

########################
layout <- matrix(c(1, 1,2, 3, 4, 5,6,7),nrow=4,byrow=T)

multiplot(p,p1,p2,p3, p4,p5,p6, cols=2,layout=layout)
