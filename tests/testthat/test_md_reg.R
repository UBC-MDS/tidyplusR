context("Create markdown table from regression object")

test_that("md_reg convert a 'lm' to markdown table", {

      lrm <- lm(data=iris, Sepal.Length  ~ Sepal.Width)

      expect_equal(md_reg(lrm , type = "estimate"),
                   "|term        |   estimate| std.error| statistic|   p.value|
                    |:-----------|----------:|---------:|---------:|---------:|
                    |(Intercept) |  6.5262226| 0.4788963| 13.627631| 0.0000000|
                    |Sepal.Width | -0.2233611| 0.1550809| -1.440287| 0.1518983|")

      expect_equal(md_reg(lrm , type = "estimate", align = "l"),
                   "|term        |   estimate| std.error| statistic|   p.value|
                    |:-----------|:----------|:---------|:---------|:---------|
                    |(Intercept) |  6.5262226| 0.4788963| 13.627631| 0.0000000|
                    |Sepal.Width | -0.2233611| 0.1550809| -1.440287| 0.1518983|")


      expect_equal(md_reg(lrm, type = "goodness"),
                   "| r.squared| adj.r.squared|     sigma| statistic|   p.value| df|    logLik|      AIC|      BIC| deviance| df.residual|
                    |---------:|-------------:|---------:|---------:|---------:|--:|---------:|--------:|--------:|--------:|-----------:|
                    | 0.0138227|     0.0071593| 0.8250966|  2.074427| 0.1518983|  2| -182.9958| 371.9917| 381.0236| 100.7561|         148|")


})
