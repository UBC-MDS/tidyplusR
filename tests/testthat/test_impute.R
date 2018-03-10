# Impute
#install.packages("testthat")
library(testthat)

context("Testing Input Outputs of Impute and Compute function")

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
  
  