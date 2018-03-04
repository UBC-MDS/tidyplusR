context("Create empty markdown table")

test_that("md_new create empty markdown table", {

      expect_equal(md_new(ncol = 2 , nrow =2, align = "l"),
                            "|   |   |
                             |:--|:--|
                             |   |   |
                             |   |   |")

      expect_equal(md_new(ncol = 3 , nrow =2, align = "r"),
                            "|   |   |   |
                             |--:|--:|--:|
                             |   |   |   |
                             |   |   |   |")

      expect_equal(md_new(ncol = 3 , nrow =2, align = "c"),
                            "|    |    |    |
                             |:--:|:--:|:--:|
                             |    |    |    |
                             |    |    |    |")
})
