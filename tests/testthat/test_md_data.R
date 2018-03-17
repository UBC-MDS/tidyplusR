context("Create markdown table from data frame")


# expected outputs
test_that("Expected outputs are correct - input matrix", {

      x <- matrix(data = c( 1:6),ncol = 3 , nrow = 2 , byrow = T)
      rownames(x) <- c("foo", "zoo")
      colnames(x) <- c("a","b","c")
      # input
      expect_equal(md_data(x),structure(c("|    |a|b|c|","|:---|---:|---:|---:|", "|foo|1|2|3|","|zoo|4|5|6|"),class="md"))


      expect_equal(md_data(x, row.index = 1:2,col.index = 1:2),
                   structure(c("|    |a|b|", "|:---|---:|---:|", "|foo|1|2|","|zoo|4|5|"),class="md"  ))

      expect_equal(md_data(x, row.names = F, header = c("A","B","C")),
                   structure(c("|A|B|C|","|---:|---:|---:|", "|1|2|3|","|4|5|6|"),class="md" ))

      expect_equal(md_data(x, align = "c"),structure(c("|    |a|b|c|","|:---|:--:|:--:|:--:|", "|foo|1|2|3|","|zoo|4|5|6|"    ),class="md"))
})

test_that("Expected outputs are correct - input data frame", {
      # test data frame
      x <- matrix(data = c( 1:6),ncol = 3 , nrow = 2 , byrow = T)
      rownames(x) <- c("foo", "zoo")
      colnames(x) <- c("a","b","c")
      x <- as.data.frame(x)

      expect_equal(md_data(x),structure(c("|    |a|b|c|","|:---|---:|---:|---:|", "|foo|1|2|3|","|zoo|4|5|6|"    ),class="md"))


      expect_equal(md_data(x, row.index = 1:2,col.index = 1:2),
                   structure(c("|    |a|b|", "|:---|---:|---:|", "|foo|1|2|","|zoo|4|5|"),class="md"  ))

      expect_equal(md_data(x, row.names = F, header = c("A","B","C")),
                   structure(c("|A|B|C|","|---:|---:|---:|", "|1|2|3|","|4|5|6|"),class="md" ))

      expect_equal(md_data(x, align = "c"),structure(c("|    |a|b|c|","|:---|:--:|:--:|:--:|", "|foo|1|2|3|","|zoo|4|5|6|"    ),class="md"))
})

test_that("Input: row.index and col.index are a vector of intnerger number", {
      # expected errors
      ## test if row.index and col.index are a vector of integer number
      expect_error(md_data(x, row.index = c("c","b","d")),"'row.index' and 'col.index' must be a vector of positive integer number")
      expect_error(md_data(x, row.index = 1:3, col.index = c(T,F,T)), "'row.index' and 'col.index' must be a vector of positive integer number")
      expect_error(md_data(x,-1:1), "'row.index' and 'col.index' must be a vector of positive integer number")
      expect_error(md_data(x,0:1), "'row.index' and 'col.index' must be a vector of positive integer number")
})


test_that("Input: 'row.names' is a logical vector of length 1", {
      ## test 'row.names' should be logical vector of length 1
      expect_error(md_data(x, row.names = 1:3),"'row.names' should be logical vector of length 1")
      expect_error(md_data(x, row.names = 123),"'row.names' should be logical vector of length 1")
      expect_error(md_data(x, row.names = "c"),"'row.names' should be logical vector of length 1")
      expect_error(md_data(x, row.names = c(T,F)),"'row.names' should be logical vector of length 1")
})


test_that("Input: 'align' is a single character of possible values 'l', 'r', and 'c'", {
      ## test: 'align' must be a single character of possible values 'l', 'r', and 'c'
      expect_error(md_data(x, align = 123),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_data(x, align = "clc"),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_data(x, align = "d"),"'align' must be a single character of possible values 'l', 'r', and 'c'")
      expect_error(md_data(x, align = T),"'align' must be a single character of possible values 'l', 'r', and 'c'")
})


test_that("Input: 'header' is a character vector of 'length = ncol'", {
      # test: 'header' should be a character vector of 'length = ncol'
      x <- matrix(data = c( 1:6),ncol = 3 , nrow = 2 , byrow = T)
      rownames(x) <- c("foo", "zoo")
      colnames(x) <- c("a","b","c")
      x <- as.data.frame(x)

      expect_error(md_data(x,header = 1:2), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_data(x,header = "foo"), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_data(x,header = c("foo","lala","boo","haha")), "'header' should be a character vector of 'length = ncol'")
      expect_error(md_data(x,header = c(T,F)),"'header' should be a character vector of 'length = ncol'")
})



