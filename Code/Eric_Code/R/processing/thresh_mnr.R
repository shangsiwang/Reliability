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
# thresh_mnr.R
# Created by Eric Bridgeford on 2015-12-03.
# Email: ebridge2@jhu.edu
# Copyright (c) 2015. All rights reserved.

# thresholding to be performed on a set of graphs, from the minimum value over the graphs 
# to the maximum value
# Inputs:
#   wgraphs [roisxroisxn]: the weighted adjacency graphs 
#   id [nx1]: the ids for the subjects
#   N[1]: the number of steps to threshold by
# Outputs:
#   mnrmax: the maximum mnr
#   Dmax: the maximum distance matrix
#   tvalmax: the threshold at the maximum mnr
#   mnrall: the mnrs at all of the thresholded values
#   tvalall: the thresholds checked
#

thresh_mnr <- function(wgraphs, id, N=50) {
  print("raw thresholding...")
  mnrmax <- 0
  mnrall <- array(dim=(N))   # initialize empty vector for the number of thresholding points we will use
  tvalall <- seq(min(wgraphs), max(wgraphs), length=N)
  for (tloc in 1:length(tvalall)) {
    corrt <- wgraphs # temporarily store the initial graphs here
    corrt[ corrt<=tvalall[tloc] ] <- 0  # make the values less than thresh 0
    corrt[ corrt > tvalall[tloc] ] <- 1 # make the values greater than thresh 1
    dist <- compute_distance(corrt) # compute the distance matrix from the set of graphs that are thresholded
    rel <- rdf(dist, id) # obtain the rdf for the subjects
    mnrall[tloc] <- mnr(rel,remove_outliers=FALSE, thresh=0) # compute the mnr from the rdf
    if (mnrall[tloc] > mnrmax) {
      mnrmax <- mnrall[tloc]
      Dmax <- dist
      tvalmax <- tvalall[tloc]
    }
  }
  pack <- list(mnrmax, Dmax, tvalmax, mnrall, tvalall)
  return(pack)
}
