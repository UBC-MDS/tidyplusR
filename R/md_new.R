#' Create Markdown table skeleton
#'
#' Creates a bare bone for generating a markdown table.
#' Alignments and size of the table can be input by users.
#'
#' @param ncol,nrow number of columns and rows for the table
#' @param align Column alignment: a character vector consisting of 'l' (left), 'c' (center) and/or 'r' (right). By default or if align = NULL, numeric columns are right-aligned, and other columns are left-aligned. If align = 'l', all columns are left aligned. e.t.c.
#' @param header A character vector of length = ncol to be used for the header of the table. Default NULL.
#'
#' @return A character vector of the table source code.
#' @export
#'
#' @examples

md_new <- function(ncol = 2, nrow = 2, align = NULL, header = NA){

}

