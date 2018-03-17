library(testthat)
library(tidyplusR)
# prepare samples
# for typemix function
sample<-read.csv("data/test_sample.csv",header = TRUE)
typemix_output2<-read.csv("data/typemix_output2.csv",header = TRUE)
typemix_output2$X1<-as.character(typemix_output2$X1)
typemix_output2$X2<-as.character(typemix_output2$X2)
typemix_output2$X3<-as.character(typemix_output2$X3)
typemix_output2$X7<-as.character(typemix_output2$X7)
typemix_output3<-read.csv("data/typemix_output3.csv",header = TRUE)
typemix_output3$character<-as.numeric(typemix_output3$character)


test_that("typemix is correct", {
  # check inputs first
  ## Input can only be data frame (data frame & tibble), not vector, list, or matrix
  expect_error(typemix(c(1,2,3,"do")), "The input should be a data frame or tibble")
  expect_error(typemix(list(c(1,2,3,"do"))), "The input should be a data frame or tibble")
  expect_error(typemix(matrix(c(1,2,3,"do"))), "The input should be a data frame or tibble")

  ## check the code accuracy
  expect_is(typemix(sample),"list")
  expect_is(typemix(sample)[[1]],"data.frame")
  expect_is(typemix(sample)[[2]],"data.frame")
  expect_is(typemix(sample)[[3]],"data.frame")
  expect_identical(typemix(sample)[[1]], sample)
  expect_identical(typemix(sample)[[2]], typemix_output2)
  expect_identical(typemix(sample)[[3]], typemix_output3)
})

