#' Check the mixture of data types
#'
#' The function helps to find the columns in a data frame that contains different types of data.
#'  R has 6 atomic vector types. The function roughly identifies if an observation belongs to one of the 3 main data types, number, logical, and character.
#'  Note, the self-defined type "number" here is an assemble of types including numeric (real and decimal), integer and complex.
#'
#' @param df a data frame
#'
#' @return A list of 3 data frames. First one is the input data frame, the second one has the same dimension as the first one,
#'  but has corresponding data type marked in the cells of the columns where mixture status is found.
#'  The third data frame is the summary of result, with ID of the columns as row names and the 3 data types as headers.
#'  It tells us the total number of each data type found in each column where mixture is found.
#'
#' @export
#' @examples
#' typemix(sample_df)
#'
typemix<-function(df){
  # check input
  if (!"data.frame" %in% class(df)){
    stop('The input should be a data frame or tibble')
  }

  # ignore warnings
  options(warn=-1)

  # locate the columns with type mixture
  ## I find that the columns with type mixture is put under factor;
  ## While the columns with only characters are also put under factor, so we need to exclude these cases.
  columns_typemix<-c()

  for (i in 1:dim(df)[2]){
    if (class(df[[i]])=="factor"){
      # identify the columns with only characters
      a<-as.numeric(as.character(df[[i]]))
      b<-as.logical(as.character(df[[i]]))
      if (sum(sum(a,na.rm=TRUE),sum(b,na.rm = TRUE))!=0){
        columns_typemix<-append(columns_typemix,i)
      }
    }
  }

  # create a data frame with the same dimension as the input df (the second df as output)
  type_df<-data.frame(matrix(NA, nrow = dim(df)[1], ncol = dim(df)[2]))
  names(type_df)<-names(df)


  # check location and number of each data type in the columns with mixed data types
  total_number<-c()
  total_logical<-c()
  total_character<-c()
  for (i in columns_typemix){
    # check if data is a number
    index<-!is.na(as.numeric(as.character(df[[i]])))
    total_number<-append(total_number,sum(index))
    type_df[index,i]<-"number"
    # check if data is logical
    index<-!is.na(as.logical(as.character(df[[i]])))
    total_logical<-append(total_logical,sum(index))
    type_df[index,i]<-"logical"
    # the rest of data should be character if we do not consider complex
    count<-0
    for (j in nrow(df)){
          if (!is.na(df[j,i] & is.na(type_df[j,i])){
                type_df[j,i]<-"character"
                count=count+1
          }
    }

    total_character<-append(total_character,count)

  }


  # create a data frame for result summary (the third df as output)
  summary_df<-data.frame(matrix(NA, nrow = length(columns_typemix), ncol = 4))
  names(summary_df)<-c("Column_ID","number", "character",	"logical")
  summary_df$Column_ID<-columns_typemix
  summary_df$number<-total_number
  summary_df$character<-total_character
  summary_df$logical<-total_logical

  # create return list with 3 data frames
  return_list<-list(df,type_df,summary_df)

  # return the output
  return(return_list)
}

