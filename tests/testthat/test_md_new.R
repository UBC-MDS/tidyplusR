context("Create empty markdown table")

test_that("md_new create empty markdown table", {
      # expected outputs:
      expect_equal(md_new(ncol = 2 , nrow =2, align = "l"),
                            structure(c("|    |    |","|:---|:---|","|    |    |","|    |    |"),class ="md"))

      expect_equal(md_new(ncol = 3 , nrow =2, align = "r"),
                            structure(c("|    |    |    |", "|---:|---:|---:|","|    |    |    |","|    |    |    |"),class ="md"))

      expect_equal(md_new(ncol = 3 , nrow =2, align = "c"),structure(c("|    |    |    |", "|:--:|:--:|:--:|", "|    |    |    |", "|    |    |    |"),class ="md"))

      # expect_errors:
      ## test if 'ncol' and 'nrow' are a integer number
      expect_error(md_new(1:2,2),"'ncol' and 'nrow' must be a positive integer number")
      expect_error(md_new("ad",2), "'ncol' and 'nrow' must be a positive integer number")
      expect_error(md_new(0,2),"'ncol' and 'nrow' must be a positive integer number")
      expect_error(md_new(-2,2), "'ncol' and 'nrow' must be a positive integer number")


      ## test: 'align' must be a single character of possible values 'l', 'r', and 'c'
      expect_error(md_new(2,2, align = 123),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_new(2,2, "clc"),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_new(2,2, "d"),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_new(2,2, l),"'align' must be a single character of possible values 'l', 'r', and 'c'")

      # test: 'header' should be a character vector of 'length = ncol'
      expect_error(md_new(header = 1:2), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_new(header = "foo"), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_new(header = c("foo","lala","boo")), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_new(header = c(T,F)),"'header' should be a character vector of 'length = ncol'")


})

