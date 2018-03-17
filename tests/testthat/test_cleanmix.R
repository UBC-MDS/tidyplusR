context("Test cleanmix function")
test_that("cleanmix input (error and warning) is correct", {
      # prepare samples
      sample<-read.csv("data/test_sample.csv",header = TRUE)
      result<-typemix(sample)

      # check inputs first
      expect_error(cleanmix(sample,column=c(1,2),type="logical"), "The input should be the result by typemix function")
      expect_warning(cleanmix(result,column=4,type="logical"), "A column does not have type mixture")
      expect_warning(cleanmix(result,column=1,type="logical"), "A column does not have the data type")


})

test_that("cleanmix output is correct",{

      # prepare samples
      sample<-read.csv("data/test_sample.csv",header = TRUE)
      cleanmix_e1<-read.csv("data/cleanmix_e1.csv",header = TRUE)
      cleanmix_e1$X2<-as.character(c("test","test",NA,NA))
      cleanmix_e1$X4<-as.numeric(cleanmix_e1$X4)
      cleanmix_e2<-sample
      cleanmix_e2$X1[4]<-NA
      result<-typemix(sample)

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
