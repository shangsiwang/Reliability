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

# fmri_utils.R
# Created by Eric Bridgeford on 2015-12-03.
# Email: ebridge2@jhu.edu
# Copyright (c) 2015. All rights reserved.

#a function to compute the winner of a dataset, as well as by how much, 
#based on the deviation from the average mnr of the dataset
compute_winner_of_param_by_mean <- function(dataset, vara) {
  library('ggplot2')
  library('reshape2')
  mean_byopt <- c()
  for (i in 3:ncol(dataset)) {
    mean_byopt[i-2] <- mean(as.numeric(dataset[[i]]))
  }
  total_mean = mean(mean_byopt) # compute the mean
  dist_tomean <- mean_byopt - total_mean # the distance to the mean
  winnerind <- (which.max(dist_tomean)) # winner is the max distance to the mean
  winnername <- colnames(dataset)[winnerind+2] # winner name is the index of winner variable
  winner_dist <- dist_tomean[winnerind]
  population <- c()
  # create the population from the elements of the dataset
  for (i in 2:ncol(dataset)) {
    population <- c(population, dataset[[i]]) 
  }
  pop_kernel <- density(as.numeric(population), n=1000, from=0, to=1) # kde of the population
  winner_kernel <- density(as.numeric(dataset[[winnerind+1]]), n=1000, from=0, to=1) # kde for the winner
  kests <- data.frame(winner_kernel$y, pop_kernel$y, winner_kernel$x) # create dataframe for mnrs vs pop kernels
  colnames(kests) <- c("winner", "full population", "MNR")
  meltkests <- melt(kests, id="MNR") # melt dataframe based on the mnr
  colnames(meltkests) <- c("MNR", "Population", "Probability Density")
  
  if (isTRUE(all.equal(winner_dist, 0))) {
    winnername <- "none" # there is no clear winner
  }
  
  winner <- list(dataset$setname[1], meltkests, vara, winnername, winner_dist)
  return(winner)
}
