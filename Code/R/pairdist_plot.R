setwd('C:/Users/shang/Desktop/Desktop/shangsi/reliability')
rm(list=ls())
# source('reliability.R')
# source('distance.R')
# source('open_graphs.R')
# 
# name<-'C:/Users/shang/Desktop/Desktop/shangsi/reliability/FSL_nff_nsc_gsr_cc2'
# graphnames <- list.files(name, pattern="\\.graphml", full.names=TRUE)
# pack<-open_graphs(graphnames,name)
# pairdist<-compute_distance(pack[[1]])
# save(pairdist,file='BNU_1_FSL_nff_nsc_gsr_cc2_pairdist.RData')

load('BNU_1_FSL_nff_nsc_gsr_cc2_pairdist.RData')
library(reshape)
library(ggplot2)



diag(pairdist)<-Inf
diag(pairdist)<-min(pairdist)
y <- melt(pairdist[1:20,1:20])
p <- ggplot(y, aes(y=X1,x=X2))+geom_tile(aes(fill=value)) + 
  #scale_fill_gradientn(name='Distance',colours = terrain.colors(100))+
  scale_fill_gradient(name='Distance',low="lightblue", high="darkblue") + 
  labs(title="Pairwise Distance Heatmap",x='', y = "")
p