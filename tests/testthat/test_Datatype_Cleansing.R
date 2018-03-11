library(testthat)
# prepare samples
# for typemix function
sample<-read.csv("data/test_sample.csv",header = TRUE)
typemix_output2<-read.csv("data/typemix_output2.csv",header = TRUE)
typemix_output2$X1<-as.character(typemix_output2$X1)
typemix_output2$X2<-as.character(typemix_output2$X2)
typemix_output2$X3<-as.character(typemix_output2$X3)
typemix_output2$X7<-as.character(typemix_output2$X7)
typemix_output3<-read.csv("data/typemix_output3.csv",header = TRUE)
# for cleanmix function
cleanmix_e1<-read.csv("data/cleanmix_e1.csv",header = TRUE)
cleanmix_e1$X2<-as.character(c("test","test",NA,NA))
cleanmix_e1$X4<-as.numeric(cleanmix_e1$X4)
cleanmix_e2<-sample
cleanmix_e2$X1[4]<-NA

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

result<-typemix(sample)


test_that("cleanmix is correct", {
  # check inputs first
  expect_error(cleanmix(sample,column=c(1,2),type="logical"), "The input should be the result by typemix function")
  expect_warning(cleanmix(result,column=4,type="logical"), "A column does not have type mixture")
  expect_warning(cleanmix(result,column=1,type="logical"), "A column does not have the data type")

  # check the code accuracy
  # first example: input 2 columns with different data types, keep=TRUE
  e1<-cleanmix(result,column=c(1,2),type=c("number","character"))
  e1$X1<-as.numeric(as.character(e1$X1))
  e1$X2<-as.character(e1$X2)
  expect_identical(e1, cleanmix_e1)
  # second example: input 1 column, keep=TRUE
  e2<-cleanmix(result,column=1,type="number")
  expect_identical(e2, cleanmix_e2)
  # third example: make keep=FALSE
  expect_identical(cleanmix(result,column=1,type="character",keep=FALSE), cleanmix_e2)

})
