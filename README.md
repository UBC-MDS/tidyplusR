# TidyPlus : tidy+

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)

[![HitCount](https://hitt.herokuapp.com/tidyplus_R.svg..)](https://github.com/tidyplus_R)

[![GitHub commit](https://img.shields.io/github/commits-since/UBC-MDS/tidyplus_R/v0.svg)](https://github.com/UBC-MDS/tidyplus_R/commit)

[![Downloads](https://img.shields.io/github/downloads/UBC-MDS/tidyplus_R/total.svg)](https://github.com/UBC-MDS/tidyplus_R/graphs/traffic)

[![forks](https://img.shields.io/github/forks/UBC-MDS/tidyplus_R.svg)](https://github.com/UBC-MDS/tidyplus_R/network)

[![issues](https://img.shields.io/github/issues/UBC-MDS/tidyplus_R.svg)](https://github.com/UBC-MDS/tidyplus_R/issues)


## Contributors:

* `Akshi Chaudhary` : [@akshi8](https://github.com/akshi8)
* `Tina Qian` : [@tina](https://github.com/TinaQian2017)
* `Xinbin Huang`: [@xinbin](https://github.com/xinbinhuang)

## Latest

* Date : Feb 11, 2018
* Release : v1.0

## About

The `tidy+` package is an essential data cleaning package with features like `missing value treatment`, `data manipulation` and displaying data as `markdown table` for documents. The package adds a few additional functionalities on the existing data wrangling packages in popular statistical softwares like R. The objective of this package was provide a few specific functions to the users to some of the pressing issues in data cleaning



## Functions included:

- `Data Manipulation` : Datatype conversions and string processing
  - `typemix`
    * The function helps to find the columns containing different types of data, like character and numeric. The input of the function is a data frame and the output of the function will be the name of the columns that have mixed types of data, all data types in the columns and the number of observations for each data type. For example, if the data frame shown below is input, the output will tell us that column A, B and C have mixed types of data. There are 3 numeric data and 1 character data in column A, 3 character data and 1 numeric data in column B, and 3 logical data and 1 numeric data in column C. Since column D only has numeric data, it will not be in the output. The additional/optional output will be the content for each data type. For example, in column A, if one choose to print the numeric/character content, he will see 1,2,3/"do"
  -  `cleanmix`
    * The function helps to clean our data frame. By using the "typemix" function, one can locate and check the discrepancy of data types in a data frame. After checking, they can use this function to keep the type of data in certain columns. Here, the input will be the name of the column (a vector of name of columns) that they want to clean, and the type of data they want to keep. The observations in other types in the columns will be Na. For example, after cleaning, if one chooses to keep numeric data, the column A in the output data frame will be "1,2,3,Na
  - `emphasizeon`
    * The function helps to emphasize some factors of interest by grouping other factors together. For example, in the `gapminder` data set, there are 5 continents, including "Africa", "Americas", "Asia", "Europe", "Oceania". If I am only interested in Asia and Europe, the function helps to mutate one column that keep Asia and Europe as "Asia" and "Europe" and rename other continents to "other". The input of the function will be a vector of factors of interest and output will be a column as described above
- `Missing Value Treatment` : Basic Imputation and EM Imputation
    * Basic Imputation : replace missing values in a column of a dataframe, or multiple columns of dataframe based on the `method` of imputation
      - (Method = 'Mean') replace using mean
      - (Method = 'Median') replace using median
      - (Method = 'Mode') replace using mode
    * EM Imputation: **Bonus**
      - Uses EM(Expectation- Maximization) algorithm to predict the closest value to the missing value
      - Can be used for both numeric and categorical predictions
- `Markdown Table`:
  * `Xinbin's Idea`

## Used Scenario

- Using Data Manipulation functionalities

  * Users can use the package when they want to clean and wrangle their data. For example, if the data has not been cleaned yet, users can use function `typemix` to check where data is not clean and use `cleanmix` to clean data. Based on personal work experience, the mix of number and character is usually seen in the data collected from survey. After clean data is ready, one can use the `Missing Value Treatment` to deal with missing data by EM algorithm. The `emphasizeon` function can be used to highlight the factors that he is interested in. After the wrangling of data, one can use function `Markdown Table` to output the data frame in a markdown format


## Existing features in Python and R ecosystem similar to tidy+ .

> **R**

* Data Manipulation
  - [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html) and [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html) these R libraries have very powerful data wrangling tools but with tidy+ user can explicitly do the do string processing/ datatype conversion without affecting the overall column type (what is you have really messed up data with mix of strings and numbers)

* Missing Value treatment
  - R doesn't have imputation methods which use `EM algorithm` for missing value treatment, which in fact is very efficient and accurate [MICE](https://cran.r-project.org/web/packages/mice/index.html) package in R do provide limited imputaion using mean, mode etc.
* Markdown table in R
  * R has library [`Kable`](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) which can output a dataset in form of a markdown table  but with tidy+ user will have more freedom with data types

## Ideas subject to change

* As a part of the initial proposal the above ideas can be implementation, however some functionalities are subject to change based on the project timeline or technical complexity
