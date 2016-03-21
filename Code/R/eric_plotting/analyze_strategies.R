# Copyright 2014 Open Connectome Project (http://openconnecto.me)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# 64figureplot.R
# Created by Eric Bridgeford on 2016-01-17.
# Email: ebridge2@jhu.edu
# Copyright (c) 2015. All rights reserved.
#
#use: RScript analyze_strategies.R /path/to/dataset.rds /path/to/output/folder/
#

# a function to plot from a particular dataframe
# Inputs
#   dataset: the dataframe of a dataset
#   param: the particular parameter we are looking at
#   target: the path to the target
# Outputs:
#   retset: the dataframe containing the specified information and regressing out the chosen parameter
plot_one_parameter <- function(dataset, param, target) {
  require('ggplot2')
  require('reshape2')
  
  relevant_cols <- c("pre","freq","scrub","gsr","at") # the columns that have the parameters are the 2nd through 6th
  relevant_cols <- relevant_cols[relevant_cols != param] # remove the one we are holding fixed
  un <- as.character(unique(dataset[[param]])) # find the unique possible values of the item we are comparing
  numel <- nrow(dataset)/length(un)
  retset <- data.frame(matrix(ncol=(length(un)+2), nrow=numel)) # preallocate
  c <- 2
  
  names(retset)[1:2] <- c("setname","fixed")
  for (i in un) {
    c <- (c + 1)
    names(retset)[c] <- i
  }

  
  unval1 <- as.character(unique(dataset[[relevant_cols[1]]]))
  unval2 <- as.character(unique(dataset[[relevant_cols[2]]]))
  unval3 <- as.character(unique(dataset[[relevant_cols[3]]]))
  unval4 <- as.character(unique(dataset[[relevant_cols[4]]]))
  
  
  univals <- array(data=NA, dim=length(un)) # where the values will be stored
  c <- 1
  for (w in unval1) {
    for (x in unval2) {
      for (y in unval3) {
        for (z in unval4) {
          #retset[c,] <- c(dataset$setname[1], paste(w,x,y,z,sep="_"),NA,NA)
          retset[c,] <- c("test", paste(w,x,y,z,sep="_"),NA,NA)
          
          for (i in un) {
            retset[c,][[i]] <- dataset[dataset[[relevant_cols[1]]]==w & dataset[[relevant_cols[2]]]==x & dataset[[relevant_cols[3]]]==y & dataset[[relevant_cols[4]]]==z & dataset[[param]]==i,]$mnr
          }
          c <- c+1
        }
      }
    }
  }
  
  mdata <- melt(retset[,-which(names(retset) %in% c("setname"))], id=c("fixed"))
  
  
  winning <- compute_winner_of_param_by_mean(retset, param)
  
  pkern <- ggplot()+geom_ribbon(data=winning[[2]], aes(x=MNR, ymax=`Probability Density`, fill=Population), ymin=0, alpha=0.5) +
    ggtitle(paste("Dataset=",winning[[1]],"variable=",winning[[3]], "Winner=", winning[[4]], ", dist=",toString(round(winning[[5]], 3))))+scale_fill_manual(values=c("blue", "green"))
  
  png(paste(target, paste(winning[[1]],winning[[3]],"winner",sep="_"),".png", sep=""), height=1000, width=1000)
  plot(pkern)
  dev.off()
  
  winner <- winning[[4]]
  dist_winner <- winning[[5]]
  z<-ggplot(data = mdata) + geom_line(aes(x=fixed, y=value, colour=variable, group=variable)) + 
    xlab("fixed processing methods") + ylab("mnr") + ggtitle(paste(dataset$setname[1],"_",param, " Comparison, winner =", winner, ", dist=",dist_winner)) + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  png(paste(target, paste(dataset$setname[1], param, "comparison", sep="_"),".png", sep=""), height=1000, width=1000)
  plot(z)
  dev.off()
  return(retset)
}

#a function to generate the overall plot of a dataset for all 64 pipelines
#Inputs:
#    dataset: has a column for the dataset name, pre, freq, scrub, gsr, and at params
#Outputs:
#    none
overall_plot <- function(dataset, target) {
  
  datasetadj <- data.frame(matrix(ncol=3, nrow=nrow(dataset)))
  names(datasetadj) <- c("setname","fixed","mnr")
  
  for (i in 1:nrow(dataset)) {
    datasetadj[i,] <- c(dataset$setname[i], paste(dataset$pre[i],dataset$freq[i],dataset$scrub[i],dataset$gsr[i],dataset$at[i],sep=""), dataset$mnr[i])
  }
  unisets <- unique(as.character(datasetadj$setname)) # store the unique set name/names as a list for the purposes of later saving
  z<-ggplot()+geom_line(data=datasetadj, aes(x=fixed, y=mnr, color=setname, group=setname)) +gg_title(paste("Overall plot", dataset$setname[1],sep=" "))
  png(paste("overallplot",paste(unisets, collapse="_"),".png", sep=""), height=1000, width=1000)
  plot(z)
  dev.off()
  
}

# a function that analyzes a dataset, and computes/plots the parameters and the winners
# dataset: a formatted data frame
# name: the name of the dataset itself

analyze_pipes <- function(dataset, target) {
  print("I get here!")
  type <- c("pre","freq","scrub","gsr","at")
  for (val in 2:6) {
    # print(paste(name, type[val-1]))
    collection <- plot_one_parameter(dataset, type[val-1], target)
  }
  overall_plot(dataset, target)
}

args <- commandArgs(trailingOnly = TRUE)

dataobj <- loadRDS(args[[1]])
target <- args[[2]]

dataset <- dataobj[[1]] # the object containing the mnr information for all the pipelines
setname <- dataobj[[2]] # the name of the dataset

analyze_pipes(dataset, target)
