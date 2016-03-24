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
# use: Rscript plot.R /path/to/thresh.rds /path/to/distance.rds /path/to/density.rds /path/to/target/folder/
#

threshold_plot <- function(thresh, name) {
  
  pthresh <- ggplot(data=thresh) +
    geom_line(data=thresh, aes(x=xvals, y=nbin, color="Nbin")) +
    geom_line(data=thresh, aes(x=xvals, y=raw, color="Raw")) +
    labs(color="thresholding method") + xlab("normalized threshold") + ylab("mnr") + ggtitle(paste(name, "comparing analysis strategies"))
  
 
  return(pthresh)

}


distance_plot <- function(Dmax, maxmnr, maxstrat) {
  
  pdist <- ggplot(melt(Dmax), aes(x=Var1, y=Var2, fill=value)) + 
    geom_tile(color="white") +
    scale_fill_gradientn(colours=c("darkblue","blue","purple","green","yellow"),name="distance") +
    xlab("Scan") + ylab("Scan") + ggtitle(paste("mnr=", toString(maxmnr), "best=", maxstrat))
  
  return(pdist)
}

density_plot <- function(hell, distance) {
  
  phell <- ggplot()+geom_ribbon(data=hell, aes(x=`Graph Distance`, ymax=Probability, fill=Subject), ymin=0, alpha=0.5) +
    ggtitle(paste("Hellinger Distance=", toString(round(distance, 3))))+scale_fill_manual(values=c("blue", "green"))
 
  return(phell) 
}

# Multiple plot function
# provided online with ggplot documentation
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

args <- commandArgs(trailingOnly = TRUE)

threshobj <- loadRDS(args[[1]])
distanceobj <- loadRDS(args[[2]])
hellobj <- loadRDS(args[[3]])
targetpath <- args[[4]]

name <- threshobj[[2]]
thresh <- threshobj[[1]]
pthresh <- threshold_plot(thresh, name)

Dmax <- distanceobj[[1]]
maxmnr <- distanceobj[[2]]
maxstrat <- distanceobj[[3]]
pdist <- distance_plot(Dmax, maxmnr, maxstrat)

meltdensity <- hellobj[[1]]
helldist <- hellobj[[2]]
phell <- density_plot(meltdensity, helldist)

png(paste(targetpath, name, "3panel",".png", sep=""), height=400, width=1500)
multiplot(pthresh, pdist, phell, cols=3)
dev.off()
