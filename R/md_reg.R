#' Create Markdown table from regression model
#'
#' Converts a regression model object into a nice-formatted markdown table.
#'
#' @param x An R regression object, i.e. "lm"
#' @param type Types of output: "estimate" gives the estimates, standard errors and p-values for the coefficients; "goodness" gives the goodness-of-fit measures, e.g. R-squared, AIC, BIC e.t.c.
#' @param align Column alignment: a character vector consisting of 'l' (left), 'c' (center) and/or 'r' (right). By default or if align = NULL, numeric columns are right-aligned, and other columns are left-aligned. If align = 'l', all columns are left aligned. e.t.c.
#'
#' @return A character vector of the table source code.
#' @export
#'
#' @examples
md_reg <- function(x, type = c("estimate", "goodness"), align = NULL){

}

