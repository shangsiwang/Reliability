dir <- dirname(parent.frame(2)$ofile)
dir <- dirname(sys.frame(1)$ofile)
setwd(dir)
source("../plotting/compute_winner_of_param_by_mean.R")
require("testthat")

test_that("clear winner test", {
  datatest <- data.frame(matrix(ncol=4, nrow=0))
  
  names(datatest) <- c("name", "fixed", "a", "b")
  name <- "test"
  fixed <- "none"
  a <- 1
  b <- 0
  datatest <- rbind(datatest, data.frame(name, fixed, a, b))
  datatest <- rbind(datatest, data.frame(name, fixed, a, b))
  
  winner <- compute_winner_of_param_by_mean(datatest, "test")
  expect_true(isTRUE(all.equal(winner[[4]], "a")))
  expect_true(isTRUE(all.equal(winner[[5]], .5))) # 1 - pop avg = .5
})

test_that("no winner test", {
  
  datatest <- data.frame(matrix(ncol=4, nrow=0))
  
  names(datatest) <- c("name", "fixed", "a", "b")
  name <- "test"
  fixed <- "none"
  a <- 0
  b <- 0
  datatest <- rbind(datatest, data.frame(name, fixed, a, b))
  datatest <- rbind(datatest, data.frame(name, fixed, a, b))
  
  winner <- compute_winner_of_param_by_mean(datatest, "test")
  
  expect_true(isTRUE(all.equal(winner[[4]], "none")))
  expect_true(isTRUE(all.equal(winner[[5]], 0)))
  
})