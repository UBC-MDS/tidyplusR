context("Test: impute missing values with the mean/median/mode")

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

