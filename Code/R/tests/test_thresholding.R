dir <- dirname(parent.frame(2)$ofile)
dir <- dirname(sys.frame(1)$ofile)
setwd(dir)
source("../processing/thresh_mnr.R")
require("testthat")
source("../../../../FlashX/Rpkg/pureR/distance.R")
source("../../../../FlashX/Rpkg/pureR/computerank.R")
source("../../../../FlashX/Rpkg/pureR/nbinstar.R")
source("../../../../FlashX/Rpkg/pureR/reliability.R")

test_that("thresholding in simple zeros vs ones case", {
  
  A <- array(0, dim=c(4, 4, 4))
  A[,,3] <- matrix(1, 4, 4)
  A[,,4] <- matrix(1, 4, 4)
  
  thresh_result <- thresh_mnr(A, c(1,1,2,2))
  
  expect_true(isTRUE(all.equal(thresh_result[[1]], 1))) # has perfect mnr, so expect to be 1
  expect_true(isTRUE(all.equal(thresh_result[[4]][50], .5))) # expect the last thresholded value to be .5 at chance
  
  ev <- matrix(0,4,4) # expect all entries to be zero except...
  ev[1,] <- c(0, 0, 4, 4) # since the euclidian norm btwn 4x4 matrices of zeros and ones is 4
  ev[2,] <- c(0, 0, 4, 4)
  ev <- ev + t(ev)
  
  expect_true(isTRUE(all.equal(thresh_result[[2]], ev)))
  
})

test_that("thresholding in simple case of subjects not matching", {
  
  A <- array(0, dim=c(4, 4, 4))
  A[,,3] <- matrix(1, 4, 4)
  A[,,4] <- matrix(1, 4, 4)
  
  thresh_result <- thresh_mnr(A, c(1,2,1,2))
  
  expect_true(isTRUE(all.equal(thresh_result[[1]], thresh_result[[4]][50], .5))) # expect the best to be matrices of zeros
  expect_true(isTRUE(all.equal(thresh_result[[2]], matrix(0, 4, 4)))) # the distances are zero at best
  expect_true(isTRUE(all.equal(thresh_result[[3]], 1))) # expect the threshold to be 1 at the best
  expect_true(isTRUE(all.equal(thresh_result[[4]][1], .25))) # expect the subject-subject match to be the worst, so 1/total(subs)
  
})