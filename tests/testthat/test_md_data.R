context("Create markdown table from data frame")

test_that("md_data convert a matrix to markdown table", {

      x <- matrix(data = c( 1:6),ncol = 3 , nrow = 2 , byrow = T)
      rownames(x) <- c("foo", "zoo")
      colnames(x) <- c("a","b","c")

      expect_equal(md_data(x),
                   "|   |  a|  b|  c|
                    |:--|--:|--:|--:|
                    |foo|  1|  2|  3|
                    |zoo|  4|  5|  6|")

      expect_equal(md_data(x, row.index = 1,col.index = c(1,2)),
                   "|   |  a|  b|
                    |:--|--:|--:|
                    |foo|  1|  2|")

       expect_equal(md_data(x, row.names = F, header = c("A","B","C")),
                   "|  A|  B|  C|
                    |--:|--:|--:|
                    |  1|  2|  3|
                    |  4|  5|  6|")

       expect_equal(md_data(x, align = "c"),
                    "|    |   a|   b|   c|
                     |:--:|:--:|:--:|:--:|
                     |foo |   1|   2|   3|
                     |zoo |   4|   5|   6|")

       expect_equal(md_data(x, align = c("c","l","c","r")),
                    "|    |  a|   b|  c|
                     |:--:|:--|:--:|--:|
                     |foo |  1|   2|  3|
                     |zoo |  4|   5|  6|")
})

test_that("md_data convert a dataframe to markdown table", {

      x <- matrix(data = c( 1:6),ncol = 3 , nrow = 2 , byrow = T)
      rownames(x) <- c("foo", "zoo")
      colnames(x) <- c("a","b","c")
      x <- as.data.frame(x)

      expect_equal(md_data(x),
                  "|   |  a|  b|  c|
                   |:--|--:|--:|--:|
                   |foo|  1|  2|  3|
                   |zoo|  4|  5|  6|")

      expect_equal(md_data(x, row.index = 1,col.index = c(1,2)),
                   "|   |  a|  b|
                    |:--|--:|--:|
                    |foo|  1|  2|")

      expect_equal(md_data(x, row.names = F, header = c("A","B","C")),
                   "|  A|  B|  C|
                    |--:|--:|--:|
                    |  1|  2|  3|
                    |  4|  5|  6|")

      expect_equal(md_data(x, align = "c"),
                   "|    |   a|   b|   c|
                    |:--:|:--:|:--:|:--:|
                    |foo |   1|   2|   3|
                    |zoo |   4|   5|   6|")

      expect_equal(md_data(x, align = c("c","l","c","r")),
                   "|    |  a|   b|  c|
                    |:--:|:--|:--:|--:|
                    |foo |  1|   2|  3|
                    |zoo |  4|   5|  6|")
})

