# Impute
#install.packages("testthat")
library(testthat)

testthat::test_file("impute.R")

testthat::context("Testing Input Outputs of Impute and Compute function")

# Test should raise an error if input or output is unexpected.

  # Load test data
 #Dummy dataset
 (data <- data.frame(v_int=as.integer(c(3,3,2,5,1,2,4,6)),
                 v_num=as.numeric(c(4.1,NA,12.2,11,3.4,1.6,3.3,5.5)),
                 v_fact=as.factor(c('one','two',NA,'two','two','one','two','two')),
                  stringsAsFactors = FALSE))
  
  (new_data <- data.frame(v_int=as.integer(c(3,3,2,5,1,2,4,6)),
                      v_num=as.numeric(c(4.1,6,12.2,11,3.4,1.6,3.3,5.5)),
                      v_fact=as.factor(c('one','two','two','two','two','one','two','two')),
                      stringsAsFactors = FALSE))
  
  method1 <- function(a){
    if (a =="mode"){
  object  <- data[,3]
    } else {object  <- data[,2]}
    return(object)
  }
  
  # These should raise an error.
  test_that("dataframe object is not list or dataframe", {
  # Expected outputs:
  expect_equal(typeof(data), "list")
  expect_equal(typeof(new_data), "list")
  expect_equal(is.data.frame(data), TRUE)
  expect_equal(is.data.frame(new_data), TRUE)
  })
  
  test_that("dataframe size miss match", {
  expect_equal(length(data) == length(new_data), TRUE)
  })
  
  
  ## Check NA in data
  test_that("No missing values", {
  expect_equal(any(is.na(data)), TRUE)
  expect_equal(any(is.na(data[,1])), FALSE)
  expect_equal(any(is.na(data[,2])), TRUE)
  expect_equal(any(is.na(data[,3])), TRUE)
  expect_equal(any(is.na(new_data)), FALSE)
  expect_equal(any(is.na(object)), TRUE)
  })
  ## Test type of each column before passing as object to impute or compute
  test_that("data type mismatch", {
  expect_equal(class(data[,1]), "integer")
  expect_equal(typeof(data[,2]), "double")
  expect_equal(class(data[,2]), "numeric")
  expect_equal(class(data[,3]), "integer")
  expect_equal(class(data[,3]), "factor")
  })
  
  ## Test if data type factor or character is using method = mode
  #method1("mode")
  test_that("method incorrect for factors and characters missing imputation", {
    
    expect_equal(class(method1("mode")), "factor")
  })
  
  ## Test if data type numeric or integer is using method = mean
 # method1("mean")
  test_that("datatype incorrect for mean/median/EM imputation",{
    
    expect_equal(class(method1("mean")), "numeric")
    expect_equal(class(method1("median")), "numeric")
    expect_equal(class(method1("EM")), "numeric")
  })
  
  
###### Tests new  ##########################
  
  
# -----------------------------------------------------------------------------
# Dummy Data
# -----------------------------------------------------------------------------

dat <- data.frame(x=sample(letters[1:3],20,TRUE), 
                                     y=sample(letters[1:3],20,TRUE),
                                     w=rnorm(20),
                                     z=sample(letters[1:3],20,TRUE), 
                                     b = as.logical(sample(0:1,20,TRUE)),
                                     a=rnorm(20),
                                     stringsAsFactors=FALSE)
  
dat[c(5,10,15),1] <- NA
dat[c(3,7),2] <- NA
dat[c(1,3,5),3] <- NA
dat[c(4,5,9),4] <- NA
dat[c(4,5,9),5] <- NA
dat[,4] <- factor(dat[,4] )
dat[c(4,5,9),6] <- NA
df <- c(1,2,3,NA)
df2 <- 2
  
  
# -----------------------------------------------------------------------------
# Input Data Params
# -----------------------------------------------------------------------------
library(testthat)
testthat::test_that("Input data is in the correct format", {

  expect_error(impute(df,"mean"), "df must be a dataframe")
  expect_error(impute(df2,"mean"), "df must be a dataframe")

})
  
# -----------------------------------------------------------------------------
# Method Params
# -----------------------------------------------------------------------------

testthat::test_that("Method string is correct", {
  # Check if method specified is mean, mode,median,EM ONLY

  expect_error(impute(dat,"max"), "method specified should be in mean, mode,median,EM ONLY")
  expect_error(impute(dat,2), "method specified should be in mean, mode,median,EM ONLY")

})



  
  
  