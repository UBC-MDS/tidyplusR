#' Impute missing values with the mean/median/mode or \code{EM}
#'
#' When the mean/median/mode method is used: character vectors and factors are imputed with the mode. 
#' Numeric and integer vectors are imputed with the mean/median.
#' When the EM method is used predictors are first imputed with the mean and each variable is then predicted and imputed with that value.
#' For predictive imputation using EM function is \code{compute}. Used to train model for imputation
#' For imputing predicted values the function is \code{impute}. Used on data to impute the values by the \code{compute} function.
#'
#' @param data A data frame with factor or numeric variables. When columns are of type "character", method=="mode" . When method="EM" columns cannot be of type "character".
#' @param method Either "mean/median/mode" or "EM". Only works if object = NULL, that is missing , NA
#' @return An imputed data frame.
#' @examples
#'#Compute the values using EM for missing data and impute them in the dataset
#'#For example:
#'
#'#Dummy dataset
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

#' @seealso \code{\link{compute}}


impute <- function (data, method="mean/median/mode/EM"){
  
  if (method=="median") {
    for(i in 1:ncol(data)){
      if(is.numeric(data[,i]) )  {
        data[is.na(data[,i]), i] <- median(data[,i], na.rm = TRUE) ## only replace numeric columns with median
      }
    }
    
    
  } else if (method=="mode") {
    
    
    mode_est <- function(x) {
      
      tab <- table(x)
      l <- sum(is.na(x))
      sample(names(tab)[tab==max(tab)], l, TRUE) ## this function find the most frequent occuring values for `mode`
      
    }
    
    for(i in 1:ncol(data)){
      if(is.factor(data[,i]) | is.character(data[,i]) | is.logical(data[,i]))  {
        data[i][is.na(data[i])] <- mode_est(data[i]) ## this function only replaces missing mode for non-numeric cols
      } else {
        
        d<- density(data[,i],na.rm = TRUE,from=min(x), to=max(x))
        md <- d$x[which.max(d$y)]
        data[i][is.na(data[i])] <- md ## this step only replaces missing with mode for numeric cols
        
      }
    }
    
  } 
  
  else if (method=="mean") {
    
    for(i in 1:ncol(data)){
      if(is.numeric(data[,i]) )  {
        data[is.na(data[,i]), i] <- mean(data[,i], na.rm = TRUE)  ## only replace numeric columns with mean
      }
    }
    
    
  }
  
  else if (method=="EM") {
    
    ##Compute EM
    # imputed_data <- data
    # imputed_data
    
  }
  
  imputed_data <- data
  imputed_data
  
}


##Usage

#impute(dat,method = "mean")



