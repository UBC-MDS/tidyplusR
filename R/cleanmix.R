#' Clean the mixture of data types
#'
#' The function helps to delete the observations with unwanted data types in indicated columns in a data frame.
#'
#' @param typemix_result the returned result (a list of 3 data frames) by typemix function.
#' @param column a number or a vector of numbers indicating the ID of columns where you want to apply the function to remove the mixture of data types
#' @param type a vector specifying the data types that you want to keep or delete.
#' @param keep if you want to keep or delete the data type you specify. The default setting is keep=TRUE.
#'
#' @return A data frame with observations in unwanted data types in the columns specified deleted.
#' @export
#' @examples
#' sample_df<-data.frame(x1=c(1,2,3,"1.2.3"),
#'                    x2=c("test","test",TRUE,100),
#'                    x3=c(1,FALSE,"FALSE "," true"),
#'                    x4=c(1,2,3,4),
#'                    x5=c("t","t","t","t"),
#'                    x6=c(TRUE,TRUE,FALSE,FALSE))
#'
#' cleanmix(typemix(sample_df),c(1,2),type=c("number","character"))
#'
#'
cleanmix<-function(typemix_result,column,type,keep=TRUE){

      # check input
      if (class(typemix_result)!="list"){
            stop('The input should be the result by typemix function')
      }

      # prepare output data
      result<-typemix_result[[1]]

      # the code for main function:
      for (i in 1:length(column)){
            ID<-column[i]
            # check if the column has type mixture
            if (ID %in% typemix_result[[3]]$Column_ID){
                  # locate the type of data of interest
                  index<-typemix_result[[2]][ID]==type[i]
                  # check if the data type exists
                  if (sum(index)==0){
                        warning("A column does not have the data type")
                  } else{
                        # check if keep or not
                        if (keep){
                              result[!index,ID]<-NA

                        } else {
                              result[index,ID]<-NA
                        }
                  }

            } else {
                  warning("A column does not have type mixture")
            }

      }

      return(result)
}
