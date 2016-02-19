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
#
# open_graphs.R
# Created by Eric Bridgeford on 2015-12-03.
# Email: ebridge2@jhu.edu
# Copyright (c) 2015. All rights reserved.
#
#a function for opening the graph data
# Input:
#   fnames[nx1]: the filenames
#   scan_pos[1]: the position of the subject id in the filenames, separated by _ characters
# Outputs:
#   graphs[kxkxn]: the graphs loaded from the specified file names
#   subjects[nx1]: the subject ids
#
open_graphs <- function(fnames, scan_pos=2) {
  print("opening graphs...")
  require('igraph')
  subjects <- c()
  numscans<-length(fnames)
  for (i in 1:numscans) { # most of the preprocessing now done in python instead
    tgraph <- read.graph(fnames[i], format='graphml') # read the graph from the filename
    basename <- basename(fnames[i])     # the base name of the file
    base_split <- strsplit(basename, "_") # parse out the subject, which will be after the study name
    subjects[i] <- unlist(base_split)[scan_pos] # subject name must be a string, so do not convert to numeric
    AdjMtx <- get.adjacency(tgraph, type="both", attr="weight", sparse=FALSE) # convert graph to adjacency matrix
    if (length(AdjMtx) != 0) { #arguments are invalid  
      if (i == 1) { # if this is the first iteration, need to initialize
        rois <- dim(AdjMtx)[1]
        graphs <- array(rep(NaN, rois*rois*numscans), c(rois, rois, numscans))
      }
      graphs[,,i] <- AdjMtx
    }
  }
  graphs[is.nan(graphs)] <- 0
  graphs[is.infinite(graphs)] <- 0
  pack <- list(graphs, subjects)# pack up the subject ids and the graphs
  return(pack)
}
