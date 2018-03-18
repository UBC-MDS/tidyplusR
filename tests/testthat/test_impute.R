
context("Impute.R")


## check all functions working properly

test_that("Expected outputs are correct - mean", {
  set.seed(0)
  
  dat1 <- read.csv("data/impute_data.csv")
  newdat1 <- impute(dat1,method="mean")
  meandat <- read.csv("data/meandat.csv")
  expect_equal(newdat1, meandat, tolerance=1e-3)
  
})
test_that("Expected outputs are correct - median", {
  set.seed(0)
  
  dat2 <- read.csv("data/impute_data.csv")
  newdat2 <- impute(dat2,method="median")
  mediandat <- read.csv("data/mediandat.csv")
  expect_equal(newdat2, mediandat,tolerance=1e-3)
  
})

test_that("Expected outputs are correct - mode", {
  set.seed(0)
  
  dat3 <- read.csv("data/impute_data.csv")
  newdat3 <- impute(dat3,method="mode")
  modedat <- read.csv("data/modedat.csv")
  modedat$b <- as.character(modedat$b)
  expect_equal(newdat3, modedat,tolerance=1e-3)
  
})

## check for inputs other than dataframe : vector, list, matrix..


test_that("Expected outputs are correct - mode", {
  
  vec <-  c(2, 'a', NA, 1, 'a', -1,NA,10,'d','e',7,9,10)
  newvec <- impute(vec,method="mode")
  expect_equal(any(is.na(newvec)), FALSE)
  
})


test_that("Expected outputs are correct - mode", {
  
  mat <- matrix(c(2, 'a', 3, 1, 'a', 7),  nrow=3, ncol=2,  byrow = TRUE)
  mat[1,2] <- NA
  mat[2,1] <- NA
  newmat <- impute(mat,method="mode")
  expect_equal(any(is.na(newmat)), FALSE)
  
})

## Since list is not accepted as input, this test for list input

test_that("Expected Inputs are correct - mode", {
  
  y <-  list(2, 'a', NA, 1, 'a', -1,NA,10,'d','e',7,9,10)
  expect_error(impute(y,method = "mode") , "input can only be vector, matrix or dataframe")
  
})


## test for other objects in R, like a function

test_that("Expected Inputs are correct - mode", {
  
  m <-  function(x)123
  expect_error(impute(m,method = "mode") , "input can only be vector, matrix or dataframe")
  
})

## test if correct method input is entered

test_that("Method input is correct - mean median mode", {
  
  n <-  c(1,2,3,4)
  expect_error(impute(n,method = "xyz") , "method can only be : mean, median, mode")
  
})


## Check if mode can handle less than two non-null values

test_that("dataframe with less than two values should impute with mean", {
  data <- c(2, NA, NA)
  df <- data.frame(data)
  expect_equal(impute(df, method="mode"), impute(df, method="mean") )
})


# These should raise error if input outputs types and shape are different

test_that("expect input and output of impute to be dataframe", {
  data <- read.csv("data/impute_data.csv")
  new_data <- impute(data,method="mean")
  # Expected outputs:
  expect_equal(typeof(data), "list")
  expect_equal(typeof(new_data), "list")
  expect_equal(is.data.frame(data), TRUE)
  expect_equal(is.data.frame(new_data), TRUE)
})

test_that("expect dimension of input and output dataframe to match", {
  data <- read.csv("data/impute_data.csv")
  new_data <- impute(data,method="mean")
  expect_equal(length(data) == length(new_data), TRUE)
})


## Check NA in data
test_that("No missing values", {
  data <- read.csv("data/impute_data.csv")
  new_data <- impute(data,method="mode")
  expect_equal(any(is.na(data)), TRUE)
  expect_equal(any(is.na(data[,2])), TRUE)
  expect_equal(any(is.na(data[,3])), TRUE)
  expect_equal(any(is.na(new_data)), FALSE)
})
