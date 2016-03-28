distance <- function(graphs, normx='F') {
  library("stats")
  dim_graphs <- dim(graphs) # get the dims of the graphs
                            # expect dim_graphs[1] to be nrois, dim_graphs[2] to be nois, dim_graphs[3] to be numsubs
  reshape_graphs <- t(array(graphs, dim=c(dim_graphs[1]*dim_graphs[2], dim_graphs[3])))
  dist_graphs <- dist(reshape_graphs, diag=TRUE, upper=TRUE) # use stats dist function
  return(array(matrix(as.matrix(dist_graphs)), dim=c(dim_graphs[3],dim_graphs[3])))
}
