
#' Impute missing values with the mean/median/mode or \code{impute}
#' 
#' When the mean/median/mode method is used: character vectors and factors are imputed with the mode. 

#' @import stats

#
#' 

#' @param data A data frame with factor or numeric variables. When columns are of type "character", method=="mode" . 
#' @param method Either "mean/median/mode". Only works if object = NULL, that is missing , NA
#' @details Numeric and integer vectors are imputed with the mean/median.For imputing missing values the function is \code{impute}. 
#' @return An imputed dataframe {data} with method selected by user



#' @examples
#'
#' #Dummy dataset
#' dat <- data.frame(x=sample(letters[1:3],20,TRUE), 
#'                   y=sample(letters[1:3],20,TRUE),
#'                   w=rnorm(20),
#'                   z=sample(letters[1:3],20,TRUE), 
#'                   b = as.logical(sample(0:1,20,TRUE)),
#'                   stringsAsFactors=FALSE)
#' 
#' dat[c(5,10,15),1] <- NA
#' dat[c(3,7),2] <- NA
#' dat[c(1,3,5),3] <- NA
#' dat[c(4,5,9),4] <- NA
#' dat[c(4,5,9),5] <- NA
#' dat[,4] <- factor(dat[,4] )
#'#Usage
#'impute(dat,method = "mean")


#' @export
#' 

impute <- function (data, method="methods"){
  
 # classes <- c("character","double","integer","logical","numeric","data.frame")

  if(is.numeric(data) | is.data.frame(data) | is.matrix(data) | is.character(data) | is.double(data))
  {
    data <- data.frame(data)  ## convert all inputs to dataframe
  } else {
    stop("input can only be vector, matrix or dataframe")
  }

  
  if (method=="median") {
    for(i in 1:ncol(data)){
      if(is.numeric(data[,i]) )  {
        data[is.na(data[,i]), i] <- stats::median(data[,i], na.rm = TRUE) ## only replace numeric columns with median
      }
    }
    
    
  } else if (method=="mode") {
    
    
    a <- 0
    mode_est <- function(a) {
      
      tab <- table(a)
      l <- sum(is.na(a))
      sample(names(tab)[tab==max(tab)], l, TRUE) ## this function find the most frequent occuring values for `mode`
      
    }
    
    
    
    for(i in 1:ncol(data)){
      if(is.factor(data[,i]) | is.character(data[,i]) | is.logical(data[,i]))  {
        data[i][is.na(data[i])] <- mode_est(data[i]) ## this function only replaces missing mode for non-numeric cols
      } else {
        
        if(length(stats::na.omit(data[,i])) < 2)
        {
          
          data[i][is.na(data[i])] <- mean(data[,i], na.rm = TRUE) ## if there are less than 2 values for mode just use mean
          
        } else {
        
          d<- stats::density(data[,i],na.rm = TRUE)
          md <- d$x[which.max(d$y)]
          data[i][is.na(data[i])] <- md ## this step only replaces missing with mode for numeric cols
          data[i] <- round(data[i],2)
        }
        
      }
    }
    
  } 
  
  else if (method=="mean") {
    
    for(i in 1:ncol(data)){
      if(is.numeric(data[,i]) )  {
        data[is.na(data[,i]), i] <- mean(data[,i], na.rm = TRUE)  ## only replace numeric columns with mean
        data[i] <- round(data[i],2)
      }
    }
    
    
  }
  
  
  
  imputed_data <- data
  imputed_data
  
}


