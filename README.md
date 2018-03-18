
<!-- README.md is generated from README.Rmd. Please edit that file -->
<img src="tidypluslogo.png" align="right" border="none" width="250" height="250"/>TidyPlusR: a tool for data wrangling
======================================================================================================================

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues) [![Build Status](https://travis-ci.org/UBC-MDS/tidyplusR.svg?branch=master)](https://travis-ci.org/UBC-MDS/tidyplusR) [![codecov](https://codecov.io/gh/UBC-MDS/tidyplusR/branch/master/graph/badge.svg)](https://codecov.io/gh/UBC-MDS/tidyplusR)

Contributors:
-------------

-   `Akshi Chaudhary` : [akshi8](https://github.com/akshi8)
-   `Tina Qian` : [TinaQian2017](https://github.com/TinaQian2017)
-   `Xinbin Huang`: [xinbinhuang](https://github.com/xinbinhuang)

Latest
------

-   Date : March 18, 2018
-   Release : v4

About
-----

The `tidyplusR` package is an essential data cleaning package with features like missing value treatment, data manipulation and displaying data as markdown table for documents. The package adds a few additional functionality on the existing data wrangling packages in popular statistical software like R. The objective of this package is to provide a few specific functions to solve some of the pressing issues in data cleaning.

Installation
------------

You can install tidyplusR from github with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/tidyplusR")
```

Functions included:
-------------------

Three main parts include different functions in `tidyplusR`

-   **Data Manipulation** : Datatype cleansing
    -   `typemix` \* The function helps to find the columns containing different types of data, like character and numeric. The input of the function is a data frame, and the output of the function will be a list of 3 data frames.
    -   `cleanmix` \* The function helps to clean our data frame. After knowing the location of discrepancy of data types, one can use this function to keep a type of data in certain columns. \* Here, the input will be the output by `typemix` function, name of the column (a vector of the name of columns) that they want to clean, the type of data they want to work on, and if we want to keep or delete the certain type. The output will be a data frame like the original type but with specified data type in certain columns deleted.
-   **Missing Value Treatment** : Basic Imputation using `impute`
    -   Imputation: replace missing values in a column of a dataframe, or multiple columns of dataframe based on the `method` of imputation

    -   `(Method = 'Mean')` replace using mean
    -   `(Method = 'Median')` replace using median
    -   `(Method = 'Mode')` replace using mode

-   **Markdown Table**:
    -   `md_new()`: This function creates a bare bone for generating a markdown table. Alignments, and size of the table can be input by users. - Input: the size of table (number of rows and number of columns) - Output: a character vector of the source code.
    -   `md_data()`: This function converts a dataframe or matrix into a markdown table format. - Input: a matrix or dataframe - Output: a character vector of the source code.

Example
-------

This is a basic example which shows you how to solve a common problem:

#### Datatype cleansing

The section has two functions, typemix and cleanmix.

-   The input for typemix function is a `data frame`, and the output is a list of 3 data frames. The first one is the same as the input data frame, the second one tells you the location and types of data in the columns where there is type mixture. The third data frame is a summary of the second data frame.

-   The input for cleanmix function is the result from typemix function, the column(s) you want to work on, the type(s) of data you want to keep/delete, and if you want to keep/delete the instances specified.

``` r
library(tidyplusR)
dat<-data.frame(x1=c(1,2,3,"1.2.3"),
                x2=c("test","test",1,TRUE),
                x3=c(TRUE,TRUE,FALSE,FALSE))

typemix(dat) #
```

    ## [[1]]
    ##      x1   x2    x3
    ## 1     1 test  TRUE
    ## 2     2 test  TRUE
    ## 3     3    1 FALSE
    ## 4 1.2.3 TRUE FALSE
    ## 
    ## [[2]]
    ##          x1        x2 x3
    ## 1    number character NA
    ## 2    number character NA
    ## 3    number    number NA
    ## 4 character   logical NA
    ## 
    ## [[3]]
    ##   Column_ID number character logical
    ## 1         1      3         1       0
    ## 2         2      1         2       1

``` r
cleanmix(typemix(dat),column=c(1,2),type=c("number","character"))
```

    ##     x1   x2    x3
    ## 1    1 test  TRUE
    ## 2    2 test  TRUE
    ## 3    3 <NA> FALSE
    ## 4 <NA> <NA> FALSE

#### Missing Value imputation

-   This function requires a `dataframe` as an input for missing value treatment using mean/median/mode

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.3.0
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ─────────────────
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
# Dummy dataframe
dat <- data.frame(x=sample(letters[1:3],20,TRUE), 
                  y=sample(letters[1:3],20,TRUE),
                  w=as.numeric(sample(0:50,20,TRUE)),
                  z=sample(letters[1:3],20,TRUE), 
                  b = as.logical(sample(0:1,20,TRUE)),
                  a=sample(0:100,20,TRUE),
                  stringsAsFactors=FALSE)

dat[c(5,10,15),1] <- NA
dat[c(3,7),2] <- NA
dat[c(1,3,5),3] <- NA
dat[c(4,5,9),4] <- NA
dat[c(4,5,9),5] <- NA
dat[,4] <- factor(dat[,4] )
dat[c(4,5,9),6] <- NA

# Calling impute function
# method can be replaced by median and mean as well

impute(dat,method = "mode") %>% head()
```

    ##   x y     w z     b     a
    ## 1 b c 24.93 b  TRUE 78.00
    ## 2 a a  3.00 b FALSE 56.00
    ## 3 c c 24.93 b  TRUE 98.00
    ## 4 a c  0.00 b  TRUE 78.34
    ## 5 c b 24.93 b  TRUE 78.34
    ## 6 a a 15.00 b FALSE 69.00

#### Markdown table

-   `md_new()` can create an empty markdown table by specifying the number of columns and number of rows.

``` r
## default: ncol = 2 and nrow = 2, alignment = "l"
md_new()
```

    ## 
    ## |    |    |
    ## |:---|:---|
    ## |    |    |
    ## |    |    |

``` r
## 3 by 3 table
md_new(nrow = 3, ncol = 3)
```

    ## 
    ## |    |    |    |
    ## |:---|:---|:---|
    ## |    |    |    |
    ## |    |    |    |
    ## |    |    |    |

``` r
## different alignments:
md_new(nrow = 1, align = "c")
```

    ## 
    ## |    |    |
    ## |:--:|:--:|
    ## |    |    |

``` r
md_new(nrow = 1, align = "r")
```

    ## 
    ## |    |    |
    ## |---:|---:|
    ## |    |    |

``` r
## providing header
h <- c("foo", "boo")
md_new(header = h)
```

    ## 
    ## | foo| boo|
    ## |:---|:---|
    ## |    |    |
    ## |    |    |

-   `md_data()` can create an markdown table given input as matrix of data frame.

``` r
md_data(mtcars, row.index = 1:3, col.index = 1:4)
```

    ## 
    ## |    |mpg|cyl|disp|hp|
    ## |:---|---:|---:|---:|---:|
    ## |Mazda RX4|21.0|6|160|110|
    ## |Mazda RX4 Wag|21.0|6|160|110|
    ## |Datsun 710|22.8|4|108|93|

``` r
## alignment to right
md_data(mtcars, row.index = 1:3, col.index = 1:4, align = "r")
```

    ## 
    ## |    |mpg|cyl|disp|hp|
    ## |:---|---:|---:|---:|---:|
    ## |Mazda RX4|21.0|6|160|110|
    ## |Mazda RX4 Wag|21.0|6|160|110|
    ## |Datsun 710|22.8|4|108|93|

``` r
## provide header
md_data(mtcars, row.index = 1:3, col.index = 1:4, header = c("a","b","c","d"))
```

    ## 
    ## |    |a|b|c|d|
    ## |:---|---:|---:|---:|---:|
    ## |Mazda RX4|21.0|6|160|110|
    ## |Mazda RX4 Wag|21.0|6|160|110|
    ## |Datsun 710|22.8|4|108|93|

``` r
## not include row names
md_data(mtcars, row.index = 1:3, col.index = 1:4, row.names = F)
```

    ## 
    ## |mpg|cyl|disp|hp|
    ## |---:|---:|---:|---:|
    ## |21|6|160|110|
    ## |21|6|160|110|
    ## |22.8|4|108|93|

Used Scenario
-------------

-   Users can use the package when they want to clean and wrangle their data. For example, if the data has not been cleaned yet, users can use function `typemix` to check where data is not clean and use `cleanmix` to clean data. Based on personal work experience, the mix of number and character is usually seen in the data collected from the survey. After clean data is ready, one can use the `impute()` to deal with missing data with mean/median/mode. The resulting data frame can be output to markdown syntax with `md_data()`. Your can also use `md_new()` to create a empty markdown table.

Existing features in R and Python ecosystem similar to `tidyplus`
-----------------------------------------------------------------

-   Data Manipulation
-   [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html) and [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html) these R libraries have very powerful data wrangling tools but with `tidyplus` user can explicitly perform string processing/ datatype conversion without affecting the overall column type (which is convenient when you have really messed up data with mix of strings and numbers)

-   Missing Value treatment
-   R doesn't have imputation methods which use `Mode` for missing value treatment, which can be useful for categorical and numeric variables [MICE](https://cran.r-project.org/web/packages/mice/index.html) package in R do provide limited imputation using mean, median, etc.
-   Markdown table in R
-   R has library [`Kable`](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) which can output a dataset in the form of a markdown table but with `tidyplus` user will have more freedom with data types and formatting.

License
-------

[MIT](LICENSE.md)

Contributing
------------

This is an open source project. Please follow the guidelines below for contribution. - Open an issue for any feedback and suggestions. - For contributing to the project, please refer to [Contributing](CONTRIBUTING.md) for details.
