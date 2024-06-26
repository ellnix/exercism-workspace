source("./difference-of-squares.R")
library(testthat)

test_that("difference of squares 0", {
  input <- 0
  expect_equal(difference_of_squares(input), 0)
})

test_that("difference of squares 5", {
  input <- 5
  expect_equal(difference_of_squares(input), 170)
})

test_that("difference of squares 10", {
  input <- 10
  expect_equal(difference_of_squares(input), 2640)
})

test_that("difference of squares 100", {
  input <- 100
  expect_equal(difference_of_squares(input), 25164150)
})

test_that("the solution has optimal performance", {
  if (!require(R.utils)) {
      install.packages("R.utils")
      library(R.utils)
  }

  result <- withTimeout({
    input <- 1e9
    difference_of_squares(input)
  }, timeout = 0.1, onTimeout = "silent")

  expect_equal(result, 2.5e+35)
})
