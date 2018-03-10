#' Impute missing values with the mean/median/mode or \code{EM}
#'
#' When the mean/median/mode method is used: character vectors and factors are imputed with the mode. 
#' Numeric and integer vectors are imputed with the mean/median.
#' When the EM method is used predictors are first imputed with the mean and each variable is then predicted and imputed with that value.
#' For predictive imputation using EM function is \code{compute}. Used to train model for imputation
#' For imputing predicted values the function is \code{impute}. Used on data to impute the values by the \code{compute} function.
#'
#' @param data A data frame with factor or numeric variables. When columns are of type "character", method=="mode" . When method="EM" columns cannot be of type "character".
#' @param object If NULL \code{impute} will call \code{compute} on the current data. 
#' @param method Either "mean/median/mode" or "EM". Only works if object = NULL, that is missing , NA
#' @return An imputed data frame.
#' @examples
#'#Compute the values using EM for missing data and impute them in the dataset
#'#For example:
#'
#'#Dummy dataset
#'(data <- data.frame(v_int=as.integer(c(3,3,2,5,1,2,4,6)),
#'                  v_num=as.numeric(c(4.1,NA,12.2,11,3.4,1.6,3.3,5.5)),
#'                  v_fact=as.factor(c('one','two',NA,'two','two','one','two','two')),
#'                  stringsAsFactors = FALSE))
#'
#'#Compute values on data
#'#EM method
#'values <- compute(data, method="EM")
#'#mean/median/mode method
#'values2 <- compute(data)
#'
#'#define new data for imputation
#'(newdata <- data.frame(v_int=as.integer(c(1,1,2,NA)),
#'                  v_num=as.numeric(c(1.1,NA,2.2,NA)),
#'                  v_fact=as.factor(c('one','one','one',NA)),
#'                  stringsAsFactors = FALSE))
#'
#'#locate the NA's
#'is.na(newdata)
#'#how many missings per variable?
#'colSums(is.na(newdata))
#'
#'#Impute on newdata
#'impute(newdata,object=values) #using EM values
#'impute(newdata,object=values2) #using mean/median/mode values
#'

#' @seealso \code{\link{compute}}
#' @author Akshi Chaudhary, Attribution: Matthijs Meire, Michel Ballings, Dirk Van den Poel, \email{Matthijs.Meire@@UGent.be}

impute <- function(data,  object=NULL, method="median/mode", flag=FALSE){
  # if (is.null(object)) object <- compute(data, method=method)
  # if (!identical(colnames(data),names(object))) stop('Variable names and variable positions need to be identical in compute and impute')
  # 
  # if (!class(object[[1]][[1]])=="EM"){
  #   data <- data.frame(sapply(1:ncol(data), function(i) {

  # } else {
  #   # first impute predictors only with median/mode
  #   predictorsImputed <- impute(data, method="median/mode")

  #     # fact <- is.factor(data[,i])
  #     # if (fact) data[,i] <- as.character(data[,i])
  #     NAs <- is.na(data[,i])
  #     data[NAs,i] <- predicted[NAs]
  #     # if (fact) data[,i] <- as.factor(data[,i])
  #     
  #   }

}



