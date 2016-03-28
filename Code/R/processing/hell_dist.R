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

# hell_dist.R
# Created by Eric Bridgeford on 2015-12-03.
# Email: ebridge2@jhu.edu
# Copyright (c) 2015. All rights reserved.

# hellinger distance computation
# Inputs:
#   D [nxn]: the distance matrix
#   id [nx1]: the set of ids corresponding to the subjects of the distance matrix
# Outputs:
#   f_intra [100x1]: the density of the probability of a intra subject based on
#       at the optimal range for the graph distances
#   f_inter [100x1]: the density of the probability of a inter subject based on
#       a graph distance for the range of graph distances
#   H: the hellinger distance
#
hell_dist <- function(D, id) {
  print("computing hellinger distances and densities...")
  intra <- vector() # array for intra
  inter <- vector() # array for inter
  numsubs <- length(id)
  for (i in 1:(numsubs-1)) {
    for (j in (i+1):numsubs) {
      if (isTRUE(all.equal(id[i],id[j]))) {
        intra <- c(intra, D[i,j]) # if we are intra sub, then append here
      } else {
        inter <- c(inter, D[i,j]) # else we are inter subject
      }
    }
  }
  intert <- density(inter) # temporary computation so that we can see what range is optimal
  intrat <- density(intra)
  bw_selection <- mean(c(intert$bw, intrat$bw))
  minx <- min(c(intrat$x, intert$x)) #compute min
  maxx <- max(c(intrat$x, intert$x)) #and max vals
  f_intra <- density(intra, from=minx, to=maxx, bw = bw_selection) # compute the density for the predetermined
  f_inter <- density(inter, from=minx, to=maxx, bw = bw_selection) # range(from, to)
  
  H = norm(sqrt(f_intra$y)-sqrt(f_inter$y), type="2")/sqrt(2) # hellinger distance from the yvals
  
  pack <- list(f_intra, f_inter, H)
  return(pack)
}
