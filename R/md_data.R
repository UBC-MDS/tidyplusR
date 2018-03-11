
#' Create Markdown table from data frame
#'
#' Converts a dataframe or matrix into a markdown table format.
#'
#' @param x An R object, typically a matrix or data frame
#' @param row.index,col.index A numeric vector correspond to the index position of the rows/columns to be included. By default, all columns and rows are included.
#' @param row.names Logical: whether to include row names. By default, row names are included if rownames(x) is neither NULL nor identical to 1:nrow(x).
#' @param header A character vector of length = ncol to be used for the header of the table. If provided, the original header will be replaced.
#' @param align Column alignment: a character vector consisting of 'l' (left), 'c' (center) and/or 'r' (right). By default or if align = NULL, numeric columns are right-aligned, and other columns are left-aligned. If align = 'l', all columns are left aligned. e.t.c.
#' @details The output markdown source code is stored as character vector in R. It can be further copied and pasted for other usage.
#' @return A character vector of the table source code.
#' @export
#'
#' @examples
#' z <- head(mtcars)
#' md_data(z)
#' md_data(z, 1:3,1:3)
#' md_data(z, 1:3,1:3, row.names = F)
#' md_data(z, 1:3,1:3, row.names = F, header = c("foo","bin","ha"))
#' md_data(z, 1:3,1:3, header = c("foo","bin","ha"), align = "c")
md_data <- function(x, row.index = NA, col.index = NA, row.names = NA, header = NA, align = NULL){

      # Condition 1: check row.index and col.index
      if (!identical(row.index,NA)){
            if (class(row.index)!= "integer"|| any(row.index<=0)){
                        stop("'row.index' and 'col.index' must be a vector of positive integer number")
            }
      }

      if (!identical(col.index,NA)){
            if (class(col.index)!= "integer"||any(col.index<=0)){
                        stop("'row.index' and 'col.index' must be a vector of positive integer number")
            }
      }
      # subsetting
      if (!identical(row.index,NA)){
            x = x[row.index,]
      }

      if (!identical(col.index,NA)){
            x = x[,col.index]
      }

      # Condition 2: row.names
      if (!identical(row.names,NA)){
            if (class(row.names)!="logical" || length(row.names)!=1){
                  stop("'row.names' should be logical vector of length 1")
            }
      }

      # Condition 3: header
      if (!identical(header, NA)){
            if(typeof(header) != "character" || length(header) != ncol(x) ){
                  stop("'header' should be a character vector of 'length = ncol'")
            }
      }


      # Condition 4: align
      if (!is.null(align)){
            if (length(align) !=1 ||
                typeof(align) != 'character' ||
                !align %in% c("l", "r", "c") ){
                  stop("'align' must be a single character of possible values 'l', 'r', and 'c'")
            }
      }

      # creating table


      len = 4
      l = paste0(":", paste(rep("-", len-1),collapse = ""))
      r = paste0(paste(rep("-", len-1),collapse = ""),":")
      c = paste0(":",paste(rep("-", len-2),collapse = ""),":")

      if (identical(header, NA))
            header = colnames(x)

      m = ncol(x)
      isn = rep(is.numeric(as.matrix(x)), m)
      if (is.null(align)){
            align = ifelse(isn, "r", "l")
      }

      if (is.na(row.names))
            row.names = has_rownames(x)
      if (!is.null(align))
            align = rep(align, length.out = m)
      if (row.names) {
            x = cbind(` ` = rownames(x), x)
            if (!is.null(col.names))
                  header = c("    ", header)
            if (!is.null(align))
                  align = c("l", align)
      }

      n = nrow(x)
      x = to_character(as.matrix(x))
      if (!is.matrix(x))
            x = matrix(x, nrow = n)
      x = trimws(x)
      colnames(x) = header
      res = apply(x, MARGIN = 1, function(z){paste0("|",paste(z, collapse = "|"),"|")})
      header = paste0("|",paste(header, collapse = "|"),"|")
      align = paste0("|",paste(unlist(mget(align)),collapse = "|"),"|")
      res = c(header, align, res)
      return(structure(res, class = "md", names =NULL))

}



to_character = function(x) {
      if (is.character(x)) return(x)
      x2 = as.character(x); dim(x2) = dim(x); dimnames(x2) = dimnames(x)
      x2
}

has_rownames = function(x) {
      !is.null(rownames(x)) && !identical(rownames(x), as.character(seq_len(NROW(x))))
}

#' @export
print.md = function(x, ...) {
      cat('\n')
      cat(x, sep = '\n')
}
