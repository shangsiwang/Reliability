dir <- dirname(parent.frame(2)$ofile)
dir <- dirname(sys.frame(1)$ofile)
setwd(dir)
source("../functions/distance.R")
require("testthat")

test_that("distance matrix in the simple case of 4 scans", {
  A <- array(0, dim=c(3,3,4))
  A[,,2] <- array(2, dim=c(3,3))
  A[,,4] <- array(2, dim=c(3,3))
  expected <- array(0,dim=c(4,4))
  expected[1,2] <- 6
  expected[1,4] <- 6
  expected[2,1] <- 6
  expected[4,1] <- 6
  expected[3,2] <- 6
  expected[3,4] <- 6
  expected[2,3] <- 6
  expected[4,3] <- 6
  
  val <- distance(A)
  expect_true(isTRUE(all.equal(val, expected)))
  
})