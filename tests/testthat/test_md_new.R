context("Test md_new - create new markdown table")

test_that("Expected outputs are correct", {
      # expected outputs:
      expect_equal(md_new(ncol = 2 , nrow =2, align = "l"),
                            structure(c("|    |    |","|:---|:---|","|    |    |","|    |    |"),class ="md"))

      expect_equal(md_new(ncol = 3 , nrow =2, align = "r"),
                            structure(c("|    |    |    |", "|---:|---:|---:|","|    |    |    |","|    |    |    |"),class ="md"))

      expect_equal(md_new(ncol = 3 , nrow =2, align = "c"),structure(c("|    |    |    |", "|:--:|:--:|:--:|", "|    |    |    |", "|    |    |    |"),class ="md"))
})

test_that("Input for 'ncol' and 'nrow' can only be integers", {
      # expect_errors:
      ## test if 'ncol' and 'nrow' are a integer number
      expect_error(md_new(1:2,2),"'ncol' and 'nrow' must be a positive integer number")
      expect_error(md_new("ad",2), "'ncol' and 'nrow' must be a positive integer number")
      expect_error(md_new(0,2),"'ncol' and 'nrow' must be a positive integer number")
      expect_error(md_new(-2,2), "'ncol' and 'nrow' must be a positive integer number")
})

test_that("Input for 'align' must be a single character of possible values 'l', 'r', or 'c'",{
      ## test: 'align' must be a single character of possible values 'l', 'r', and 'c'
      expect_error(md_new(2,2, align = 123),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_new(2,2, "clc"),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_new(2,2, "d"),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_new(2,2, T),"'align' must be a single character of possible values 'l', 'r', and 'c'")
})

test_that("Input for 'header' should be a character vector of 'length =ncol'", {
      # test: 'header' should be a character vector of 'length = ncol'
      expect_error(md_new(header = 1:2), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_new(header = "foo"), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_new(header = c("foo","lala","boo")), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_new(header = c(T,F)),"'header' should be a character vector of 'length = ncol'")
})

