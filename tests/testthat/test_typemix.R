context("Test typemix function")
test_that("typemix input is correct", {
      ## Input can only be data frame (data frame & tibble), not vector, list, or matrix
      expect_error(typemix(c(1,2,3,"do")), "The input should be a data frame or tibble")
      expect_error(typemix(list(c(1,2,3,"do"))), "The input should be a data frame or tibble")
      expect_error(typemix(matrix(c(1,2,3,"do"))), "The input should be a data frame or tibble")
})


test_that("typemix output type is correct",{
      # prepare samples
      sample<-read.csv("data/test_sample.csv",header = TRUE)
      # check code accuracy
      expect_is(typemix(sample),"list")
      expect_is(typemix(sample)[[1]],"data.frame")
      expect_is(typemix(sample)[[2]],"data.frame")
      expect_is(typemix(sample)[[3]],"data.frame")
})


test_that("typemix output objects are correct",{
      # prepare data
      sample<-read.csv("data/test_sample.csv",header = TRUE)
      typemix_output2<-read.csv("data/typemix_output2.csv",header = TRUE)
      typemix_output2$X1<-as.character(typemix_output2$X1)
      typemix_output2$X2<-as.character(typemix_output2$X2)
      typemix_output2$X3<-as.character(typemix_output2$X3)
      typemix_output2$X7<-as.character(typemix_output2$X7)
      typemix_output3<-read.csv("data/typemix_output3.csv",header = TRUE)
      typemix_output3$character<-as.numeric(typemix_output3$character)

      ## check the code accuracy
      expect_identical(typemix(sample)[[1]], sample)
      expect_identical(typemix(sample)[[2]], typemix_output2)
      expect_identical(typemix(sample)[[3]], typemix_output3)
})
