#' Read data at a given directory and factor columns if needed
#'
#' @param input_dir The directory where the file to be read is located
#' @param factor_vars a single string or vector of strings representing variables to factor
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' read_and_factor('data/unfactored_populated_data.csv', "cultivar")
#' read_and_factor('data/unfactored_populated_data.csv',
#' c("cultivar","alcohol"))
read_and_factor <- function(input_dir, factor_vars = NULL) {
  # Check if the input directory exists
  if (!file.exists(input_dir)) {
    stop("Input file does not exist")
  }

  data <- readr::read_csv(input_dir)

  # Check if factor_vars is a string or a vector of strings
  if (!is.character(factor_vars) && !all(sapply(factor_vars, is.character))) {
    stop("factor_vars must be a string or a vector of strings")
  }

  # If only one variable is given, turn it into a vector
  if (is.character(factor_vars)) {
    factor_vars <- as.vector(factor_vars)
  }

  if (!is.null(factor_vars)) {
    # If factor_vars is a single string, convert it to a vector
    if (length(factor_vars) == 1) {
      factor_vars <- as.character(factor_vars)
    }

    # Check if the specified variable exists in the dataframe
    if (!all(factor_vars %in% colnames(data))) {
      warning("Invalid variable(s) specified in factor_vars")
    } else {
      for (var in factor_vars) {
        data[[var]] <- factor(data[[var]])
      }
    }
  }
  return(data)
}

