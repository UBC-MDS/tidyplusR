#' Predict the most expected value of a missing data in a dataset using EM algorithm or Mean/Mode/Median
#'
#' character vectors and factors are imputed with the mode.
#' Numeric and integer vectors are imputed with the median/Mean
#' When the EM method is used expected values are first imputed with the mean and each variable is then imputed with the expected value

#'#Compute the values using EM for missing data and impute them in the dataset
#'#For example:
#'

#'#Impute on newdata
#'impute(newdata,object=values) #using EM values

#' @seealso \code{\link{impute}}
#' @author Akshi Chaudhary
compute <- function (data, method="EM")
{

 if (method=="EM") {

##Coming Soon
 }
}
