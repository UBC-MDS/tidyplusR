#' Create Markdown table skeleton
#'
#' Creates a bare bone for generating a markdown table.
#' Alignments and size of the table can be input by users.
#'
#' @param nrow,ncol number of columns and rows for the table
#' @param align Column alignment: a single character of 'l' (left), 'c' (center) and/or 'r' (right). If align = 'l', all columns are left aligned. e.t.c.
#' @param header A character vector of length = ncol to be used for the header of the table. Default NA.
#' @details The output markdown source code is stored as character vector in R. It can be further copied and pasted for other usage.
#'
#' @return A character vector of the table source code.
#' @export
#' @seealso  Other R packages such as `huxtable`, `xtable`, `kableExtra`, and `tables` for HTML and LaTeX tables, and ascii and pander for different flavors of markdown output and some advanced features and table styles.
#' @examples
#' md_new(2,3, align = "c")
#' md_new(2,3, header = c("a", "b", "c"))

md_new <- function(nrow = 2, ncol = 2, align = NULL, header = NA){

      # Condition 1: check type of align
      if (!is.null(align)){
            if (length(align) !=1 ||
                  typeof(align) != 'character' ||
            !align %in% c("l", "r", "c") ){
                  stop("'align' must be a single character of possible values 'l', 'r', and 'c'")
            }
      }
      # Condition 2: check type of header
      if (!identical(header, NA)){
            if(typeof(header) != "character" || length(header) != ncol ){
                  stop("'header' should be a character vector of 'length = ncol'")
            }
      }

      # Condition 3: check ncol and nrow
      if (class(c(ncol,nrow))== "numeric" && length(c(ncol, nrow))==2){
            if (ncol %% 1 !=0 || nrow %%1 !=0){
                  stop("'ncol' and 'nrow' must be a integer number")}
      } else {
            stop("'ncol' and 'nrow' must be a integer number")
      }

      # create table
      n.pipe = ncol +1

      len = max(nchar(trimws(header)), 4, na.rm = T)
      space = paste(rep(" ", len), collapse = "")
      row = paste(rep("|", n.pipe), collapse = space)

      l = paste0(":", paste(rep("-", len-1),collapse = ""))
      r = paste0(paste(rep("-", len-1),collapse = ""),":")
      c = paste0(":",paste(rep("-", len-2),collapse = ""),":")

      if (identical(header, NA)){
            header <- row
      } else {
            header = sapply(header, function(x)paste0(paste(rep(" ", len - nchar(x)),collapse = ""),x) )
            header = paste(header, collapse = "|")
            header = paste0("|",header,"|")
      }

      if (is.null(align)){
            align = l
      } else align = get(align)

      align = paste(rep(align, ncol), collapse = "|")
      align = paste0("|",align,"|")

      res = c(header, align, rep(row, nrow))
      return(structure(res, class = "md"))
}

#' @export
print.md = function(x, ...) {
      cat('\n')
      cat(x, sep = '\n')
}
