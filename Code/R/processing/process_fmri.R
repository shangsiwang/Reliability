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

# process_fmri.R
# Created by Eric Bridgeford on 2015-09-14.
# Email: ebridge2@jhu.edu
# Copyright (c) 2015. All rights reserved.
#Usage:
# Rscript process_fmri.R /path/to/base/directory/of/pipeline/folders/ /path/to/base/target/with/pipeline/folders/

#
# a function to analyze a dataset given several inputs
# gpath is the path to the pre-processed graph outputs folder
# inputs:
#   gpath: the path to the folder containing one pipeline worth of data
#   name: the standard name that will form the basis of all names for output files
#   scan_pos: the position of the subject id in the output data; should be formatted
#     as dataset_subjectid_graph.graphml
#   tpath: the target path to place all output files
#outputs:
#   maxmnr: the maximum mnr for this pipeline
#
compute_single_pipe <- function(gpath, name, scan_pos, tpath) {
  require('ggplot2')
  require('reshape2')
  source("open_graphs.R")
  source("thresh_mnr.R")
  source("../../FlashRupdated/functions/reliability.R")
  source("../../FlashRupdated/functions/nbinstar.R")
  source("hell_dist.R")
  print(name)
  #get the graphs from wherever we are
  
  saveLoc <- paste(tpath, "graphs.rds", sep="")
  
  if (!file.exists(saveLoc)) {
    graphnames <- list.files(gpath, pattern="\\.graphml", full.names=TRUE)
    numscans <- length(graphnames)
    parsed_graphs <- open_graphs(graphnames, scan_pos)
    saveRDS(parsed_graphs, saveLoc)
  } else {
    parsed_graphs <- readRDS(saveLoc)
  }
      
  wgraphs <- parsed_graphs[[1]]
  ids <- parsed_graphs[[2]]
  
  thresh_raw <- thresh_mnr(wgraphs, ids, N=25)
  
  thresh_nbin <- nbinstar(wgraphs, ids, N=2, lim=dim(wgraphs)[1]^2)
  maxmnr <- NULL
  maxstrat <- NULL
  if (pmax(thresh_nbin[[1]], thresh_raw[[1]]) == thresh_nbin[[1]]) {
    maxmnr <- thresh_nbin[[1]]
    maxthresh <- thresh_nbin[[2]]
    Dmax <- thresh_nbin[[3]]
    maxstrat <- "nbin*"
  } else {
    maxmnr <- thresh_raw[[1]]
    maxthresh <- thresh_raw[[3]]
    Dmax <- thresh_raw[[2]]
    maxstrate <- "raw"
  }
  helldist <- hell_dist(Dmax, ids)
  
  ##first vara for the thresholding results
  norm_thresh <- seq(0, 1, length=25)
  dthresh <- data.frame(y1=approx(x=thresh_nbin[[6]],y=thresh_nbin[[5]], n=25, method='linear')$y, y2=thresh_raw[4], x=norm_thresh)
  colnames(dthresh) <- c("nbin", "raw", "xvals")
  threshobj <- list(dthresh, name)
  saveRDS(threshobj, paste(tpath, "thresh.rds", sep=""))
  
  Distance_object <- list(Dmax, maxmnr, maxstrat, name)
  ##second vara for the best results
  saveRDS(Distance_object, paste(tpath, "distance.rds", sep=""))
  
  
  ##third plot for the hellinger distance
  dhell <- data.frame(helldist[[1]]$y, helldist[[2]]$y, helldist[[1]]$x)
  colnames(dhell) <- c("fintra", "finter", "Graph Distance")
  meltdhell <- melt(dhell, id="Graph Distance")
  colnames(meltdhell) <- c("Graph Distance", "Subject", "Probability")
  hellobj <- list(meltdhell, helldist[[3]], name)
  saveRDS(hellobj, paste(tpath, "hell.rds", sep=""))
  
  return(maxmnr)
}

# computes all of the desired analysis for a dataset
# Inputs:
#   gpath: the path to the base directory containing the formatted input folders
#   setname: the name of the dataset
# Outputs:
#   dataset: a dataframe containing all the information about the dataset collected over the pipeline
#
compute_set_of_pipes <- function(gpath, setname, tpath, pos) {
  dataset <- data.frame(matrix(ncol=8, nrow=0))
  names(dataset) <- c("name", "pre", "freq", "scrub", "gsr", "at", "path", "mnr")
  pres <- c("ANT", "FSL")
  nuis <- c("gsr", "ngs")
  freq <- c("frf", "nff")
  scrub <- c("scr", "nsc")
  masks <- c("aal","cc2","des","hox")
  i <- 1
  for (v in pres) {
    for (w in freq) {
      for (x in scrub) {
        for (y in nuis) {
          for (z in masks) {
            name <- paste(setname, v, w, x, y, z, sep="_")
            folder <- paste(v, w, x, y, z, sep="_")
            #target path  for outputs of the inner loop is the folder for that pipeline
            path <- paste(gpath, folder, "/", sep="")
            mnr <- compute_single_pipe(path, name, pos, paste(tpath, folder, "/", sep=""))
            test <- data.frame(setname, v, w, x, y, z, path, mnr)
            dataset <- rbind(dataset, test)
          }
        }
      }
    }
  }
  dataobj <- list(dataset, setname)
  saveRDS(dataobj, paste(tpath,"mnr_for_pipes.rds"))
  return(dataset)
}


args <- commandArgs(trailingOnly = TRUE)

basepath <- args[[1]] # the base path to the graphml derivatives for a dataset

targetpath <- args[[2]] # path of the destination for the outputs... should have the folders setup appropriately

scanPos <- as.numeric(args[[3]])

nameset <- unlist(strsplit(basepath, split="/"))[6]

print(nameset)

compute_set_of_pipes(gpath = basepath, setname = nameset, tpath = targetpath, pos = scanPos)
