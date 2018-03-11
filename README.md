# TidyPlus: a tool for data wrangling

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)

[![HitCount](https://hitt.herokuapp.com/tidyplus_python.svg..)](https://github.com/tidyplus_python)

[![GitHub commit](https://img.shields.io/github/commits-since/UBC-MDS/tidyplus_python/v0.svg)](https://github.com/UBC-MDS/tidyplus_python/commit)

[![Downloads](https://img.shields.io/github/downloads/UBC-MDS/tidyplus_python/total.svg)](https://github.com/UBC-MDS/tidyplus_python/graphs/traffic)

[![forks](https://img.shields.io/github/forks/UBC-MDS/tidyplus_python.svg)](https://github.com/UBC-MDS/tidyplus_python/network)

[![issues](https://img.shields.io/github/issues/UBC-MDS/tidyplus_python.svg)](https://github.com/UBC-MDS/tidyplus_python/issues)



## Contributors:

* `Akshi Chaudhary` : [@akshi8](https://github.com/akshi8)

* `Tina Qian` : [@TinaQian2017](https://github.com/TinaQian2017)
* `Xinbin Huang`: [@xinbinhuang](https://github.com/xinbinhuang)


## Latest

* Date : Feb 11, 2018
* Release : v3

## About


The `tidyplus` package is an essential data cleaning package with features like `missing value treatment`, `data manipulation` and displaying data as `markdown table` for documents. The package adds a few additional functionalities on the existing data wrangling packages in popular statistical softwares like R. The objective of this package is to provide a few specific functions to solve some of the pressing issues in data cleaning.


## Installation

You can install tidyplusR from github with:


``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/tidyplusR")
```



## Functions included:

Three main parts including different functions in `tidyplus`
- `Data Manipulation` : Datatype cleansing
  - `typemix`
    * The function helps to find the columns containing different types of data, like character and numeric. The input of the function is a data frame, and the output of the function will be a list of 3 data frames.
  - `cleanmix`
    * The function helps to clean our data frame. After knowing the location of discrepancy of data types, one can use this function to keep a type of data in certain columns. Here, the input will be the output by `typemix` function, name of the column (a vector of the name of columns) that they want to clean, the type of data they want to work on, and if we want to keep or delete the certain type. The output will be a data frame like the original one but with specified data type in certain columns deleted.

- `Missing Value Treatment` : Basic Imputation and EM Imputation - `impute`

    * Basic Imputation: replace missing values in a column of a dataframe, or multiple columns of dataframe based on the `method` of imputation

      - (Method = 'Mean') replace using mean
      - (Method = 'Median') replace using median
      - (Method = 'Mode') replace using mode
    * EM Imputation: **Bonus** (method = "EM")
      - Uses EM(Expectation- Maximization) algorithm to predict the closest value to the missing value
- `Markdown Table`:

  - `md_new()`: This function creates a bare bone for generating a markdown table. Alignments, and size of the table can be input by users.
    - Input: the size of table (number of rows and number of columns)
    - Outpu:  a character vector of the source code.
  - `md_data()`: This function converts a dataframe or matrix into a markdown table format.
    - Input: a matrix or dataframe
    - Output: a character vector of the source code.
  - `md_reg()`: This function converts a regression model object into a nice-formatted markdown table.
    - Input: a regression object (i.e. `lm`) and the type of outputs of the regression object.
    - Output: a character vector of the source code.

## Example

This is a basic example which shows you how to solve a common problem:

#### Datatype cleansing

The section has two functions, typemix and cleanmix.

- The input for typemix function is a `data frame`, and the output is a list of 3 data frames. The first one is the same as the input data frame, the second one tells you the location and types of data in the columns where there is type mixture. The third data frame is a summary of the second data frame.

- The input for cleanmix function is the result from typemix function, the column(s) you want to work on, the type(s) of data you want to keep/delete, and if you want to keep/delete the instances specified. 

```r
dat<-data.frame(x1=c(1,2,3,"1.2.3"),
                x2=c("test","test",1,TRUE),
                x3=c(TRUE,TRUE,FALSE,FALSE))

typemix(dat) #

cleanmix(typemix(dat),column=c(1,2),type=c("number","character"))
```

#### Missing Value imputation

* This function requires a `dataframe` as an input for missing value treatmet using mean/median/mode
``` r

### Dummy dataframe
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

#### Calling impute function

library(tidyplusR)

impute(dat,method = "mode")  ## method can be replaced by median and mean as well

```


## Used Scenario

Using Data Manipulation functionalities

  * Users can use the package when they want to clean and wrangle their data. For example, if the data has not been cleaned yet, users can use function `typemix` to check where data is not clean and use `cleanmix` to clean data. Based on personal work experience, the mix of number and character is usually seen in the data collected from the survey. After clean data is ready, one can use the `Missing Value Treatment` to deal with missing data by EM algorithm. The `emphasizeon` function can be used to highlight the factors that he is interested in. After the wrangling of data, one can use function `Markdown Table` to output the data frame in a markdown format.


## Existing features in R and Python ecosystem similar to `tidyplus`


* Data Manipulation
  - [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html) and [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html) these R libraries have very powerful data wrangling tools but with `tidyplus` user can explicitly perform string processing/ datatype conversion without affecting the overall column type (which is convenient when you have really messed up data with mix of strings and numbers)

* Missing Value treatment
  - R doesn't have imputation methods which use `EM algorithm` for missing value treatment, which in fact is very efficient and accurate [MICE](https://cran.r-project.org/web/packages/mice/index.html) package in R do provide limited imputation using mean, mode, etc.
* Markdown table in R
  * R has library [`Kable`](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) which can output a dataset in the form of a markdown table but with `tidyplus` user will have more freedom with data types and formatting.

## Ideas subject to change

* As a part of the initial proposal, the above ideas can be implemented. However, some functionalities are subject to change based on the project timeline or technical complexity

## License
[MIT](LICENSE.md)

## Contributing
This is an open source project. Please follow the guidelines below for contribution.
  - Open an issue for any feedback and suggestions.
  - For contributing to the project, please refer to [Contributing](CONTRIBUTING.md) for details.
