# prepare samples
# for typemix function
sample<-read.csv("data/test_sample.csv",header = TRUE)
typemix_output2<-read.csv("data/typemix_output2.csv",header = TRUE)
typemix_output3<-read.csv("data/typemix_output3.csv",header = TRUE)
# for cleanmix function
cleanmix_e1<-read.csv("data/cleanmix_e1.csv",header = TRUE)
cleanmix_e2<-read.csv("data/cleanmix_e2.csv",header = TRUE)
cleanmix_e3<-read.csv("data/cleanmix_e3.csv",header = TRUE)

test_that("typemix is correct", {
  # check inputs first
  ## Input can only be data frame (data frame & tibble), not vector, list, or matrix
  expect_error(typemix(c(1,2,3,"do")), "The input should be a data frame or tibble")
  expect_error(typemix(list(c(1,2,3,"do"))), "The input should be a data frame or tibble")
  expect_error(typemix(matrix(c(1,2,3,"do"))), "The input should be a data frame or tibble")

  ## check the code accuracy
  expect_is(typemix(sample),"list")
  expect_is(typemix(sample)[1],"data.frame")
  expect_is(typemix(sample)[2],"data.frame")
  expect_is(typemix(sample)[3],"data.frame")
  expect_identical(typemix(sample)[1], sample)
  expect_identical(typemix(sample)[2], typemix_output2)
  expect_identical(typemix(sample)[3], typemix_output3)
})

test_that("cleanmix is correct", {
  # check inputs first
  expect_error(cleanmix(sample,column=c(1,2),type,keep), "The input should be the result by typemix function")
  expect_warning(cleanmix(typemix(sample),column=c(1,4),type,keep), "Column 4 does not have type mixture")
  expect_warning(cleanmix(typemix(sample),column=c(1),type="logical",keep), "Column 1 does not have logical data")

  # check the code accuracy
  # first example: keep type and keep as default: type=majority, keep=TRUE
  expect_identical(cleanmix(typemix(sample),column=c(1,2),type,keep), cleanmix_e1)
  # second example: specify type
  expect_identical(cleanmix(typemix(sample),column=c(1,2),type="number",keep), cleanmix_e2)
  # third example: make keep=FALSE
  expect_identical(cleanmix(typemix(sample),column=c(1,2),type="character",keep=FALSE), cleanmix_e3)

})
