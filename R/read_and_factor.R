#' Read data at a given directory and factor columns if needed
#'
#' @param input_dir The directory where the file to be read is located
#' @param factor_vars a single string or vector of strings representing variables to factor
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' read_and_factor('~/predictcultivar/tests/testthat/data/unfactored_populated_data.csv', "cultivar")
#' read_and_factor('~/predictcultivar/tests/testthat/data/unfactored_populated_data.csv', c("cultivar","alcohol"))
read_and_factor <- function(input_dir, factor_vars = NULL) {
  data <- readr::read_csv(input_dir)
  if (!is.null(factor_vars)) {
    for (var in factor_vars) {
      if (var %in% colnames(data)) {
        data[[var]] <- factor(data[[var]])
      } else {
        warning(paste("Variable", var, "not found in the dataframe."))
      }
    }
  }
  return(data)
}


