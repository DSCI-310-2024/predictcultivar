#' Calculate the mean and standard deviation for all numerical columns in a dataframe
#'
#' @param data A dataframe containing the data to summarize
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' df <- data.frame(
#' a = rnorm(5),
#' b = rnorm(5))
#' calc_stats(df)
calc_stats <- function(data) {
  if (!is.data.frame(data)) {
    stop("`data` should be a data frame or data frame extension (e.g. a tibble)")
  }

  # Select only numeric columns
  numeric_columns <- data |>
    dplyr::select_if(is.numeric)

  # Produce an error if there are no numeric columns
  if (is_empty <- nrow(numeric_columns) == 0 || ncol(numeric_columns) == 0) {
    stop("There are no numeric columns in the dataframe.")
  }

  var_names <- names(numeric_columns)

  # Create an empty data frame to store statistics
  summary_df <- data.frame(
    matrix(NA, nrow = 2, ncol = length(var_names)),
    row.names = c("Mean", "SD")
  )
  colnames(summary_df) <- var_names

  # Calculate statistics for each column
  for (var in var_names) {
    summary_df["Mean", var] <- mean(numeric_columns[[var]], na.rm = TRUE)
    summary_df["SD", var] <- stats::sd(numeric_columns[[var]], na.rm = TRUE)
  }

  # Return the dataframe of statistics
  return(summary_df)
}
