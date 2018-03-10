
#' Create Markdown table from data frame
#'
#' Converts a dataframe or matrix into a markdown table format.
#'
#' @param x An R object, typically a matrix or data frame
#' @param row.index,col.index A numeric vector correspond to the index position of the rows/columns to be included. By default, all columns and rows are included.
#' @param row.names Logical: whether to include row names. By default, row names are included if rownames(x) is neither NULL nor identical to 1:nrow(x).
#' @param header A character vector of length = ncol to be used for the header of the table. If provided, the original header will be replaced.
#' @param align Column alignment: a character vector consisting of 'l' (left), 'c' (center) and/or 'r' (right). By default or if align = NULL, numeric columns are right-aligned, and other columns are left-aligned. If align = 'l', all columns are left aligned. e.t.c.
#'
#' @return A character vector of the table source code.
#' @export
#'
#' @examples
md_data <- function(x, row.index = NA, col.index = NA, row.names = NA, header = NA, align = NULL){

}

