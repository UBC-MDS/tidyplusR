#' Predict the most expected value of a missing data in a dataset using EM algorithm or Mean/Mode/Median
#'
#' character vectors and factors are imputed with the mode. 
#' Numeric and integer vectors are imputed with the median/Mean
#' When the EM method is used expected values are first imputed with the mean and each variable is then imputed with the expected value

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
#' @seealso \code{\link{impute}}
#' @author Akshi Chaudhary, Attribution: Matthijs Meire, Michel Ballings, Dirk Van den Poel, \email{Matthijs.Meire@@UGent.be}
compute <- function (data, method="median/mode", ...)
{
  
  # if (method=="median/mode") {
  #   Mode <- function(x) {

  #   values <- sapply(data, function(x) {
  #     if (class(x) %in% c("character", "factor"))
  #       Mode(x)

  # } else if (method=="EM") {
  #
  #   data <- impute(data, method="mean")
  #
  #   values <- list()
  #   for (i in 1:ncol(data)){
  #     values[[i]][[1]] <- EM(x=data[,-i,drop=FALSE],y= data[,i], ...)
  #   }
  #   names(values) <- colnames(data)
  # }
  # values
}


