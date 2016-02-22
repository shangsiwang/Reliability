dir <- dirname(parent.frame(2)$ofile)
dir <- dirname(sys.frame(1)$ofile)
setwd(dir)
source("../processing/hell_dist.R")
require("testthat")

test_that("hellinger distance in matrix of zeros case", {
  A <- matrix(0, 4, 4)
  
  hell_test <- hell_dist(A, c(1,1,2,2))
  
  # dhell <- data.frame(hell_test[[1]]$y, hell_test[[2]]$y, hell_test[[1]]$x)
  # colnames(dhell) <- c("fintra", "finter", "Graph Distance")
  # meltdhell <- melt(dhell, id="Graph Distance")
  # colnames(meltdhell) <- c("Graph Distance", "Subject", "Probability")
  # hell <- meltdhell
  # phell <- ggplot()+geom_ribbon(data=hell, aes(x=`Graph Distance`, ymax=Probability, fill=Subject), ymin=0, alpha=0.5) +
  #   ggtitle(paste("Hellinger Distance=", toString(round(distance, 3))))+scale_fill_manual(values=c("blue", "green"))
  
  expect_true(isTRUE(all.equal(sum(hell_test[[2]]$x*hell_test[[2]]$y), 0)))
  expect_true(isTRUE(all.equal(sum(hell_test[[1]]$x*hell_test[[1]]$y), sum(hell_test[[2]]$x*hell_test[[2]]$y))))
  expect_true(isTRUE(all.equal(hell_test[[3]], 0))) # expect the difference of two zero ras to be zero
})

test_that("hellinger distance in subjects not identical case", {
  
  A <- matrix(0, 4, 4)
  A[1,3] <- 1
  A[1,4] <- 1
  A[2,3] <- 1
  A[2,4] <- 1
  A <- A + t(A)
  

  hell_test <- hell_dist(A, c(1,1,2,2))
  
  # dhell <- data.frame(hell_test[[1]]$y, hell_test[[2]]$y, hell_test[[1]]$x)
  # colnames(dhell) <- c("fintra", "finter", "Graph Distance")
  # meltdhell <- melt(dhell, id="Graph Distance")
  # colnames(meltdhell) <- c("Graph Distance", "Subject", "Probability")
  # hell <- meltdhell
  # phell <- ggplot()+geom_ribbon(data=hell, aes(x=`Graph Distance`, ymax=Probability, fill=Subject), ymin=0, alpha=0.5) +
  #   ggtitle(paste("Hellinger Distance=", toString(round(distance, 3))))+scale_fill_manual(values=c("blue", "green"))
  
})