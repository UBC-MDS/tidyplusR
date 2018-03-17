context("Impute missing values in a dataframe")

set.seed(0)

test_that("Expected outputs are correct - mean", {
  
  dat1 <- read.csv("data/impute_data.csv")
  newdat1 <- impute(dat1,method="mean")
  meandat <- read.csv("data/meandat.csv")
  expect_equal(newdat1, meandat)
  
})
test_that("Expected outputs are correct - median", {
  
  dat2 <- read.csv("data/impute_data.csv")
  newdat2 <- impute(dat2,method="median")
  mediandat <- read.csv("data/mediandat.csv")
  expect_equal(newdat2, mediandat)
  
})
test_that("Expected outputs are correct - mode", {
  
  dat3 <- read.csv("data/impute_data.csv")
  newdat3 <- impute(dat3,method="mode")
  modedat <- read.csv("data/modedat.csv")
  modedat$b <- as.character(modedat$b)
  expect_equal(newdat3, modedat)
  
})




# These should raise an error.
test_that("dataframe object is not list or dataframe", {
  data <- read.csv("data/impute_data.csv")
  new_data <- impute(data,method="mean")
  # Expected outputs:
  expect_equal(typeof(data), "list")
  expect_equal(typeof(new_data), "list")
  expect_equal(is.data.frame(data), TRUE)
  expect_equal(is.data.frame(new_data), TRUE)
})

test_that("dataframe size miss match", {
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
