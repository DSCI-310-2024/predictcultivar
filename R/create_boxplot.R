#' Create a box plot
#'
#' @param data A dataframe containing the data to plot.
#' @param x A variable in the dataframe that will be on the plot's x axis.
#' @param y A variable in the dataframe that will be on the plot's y axis.
#'
#' @return a boxplot
#' @export
#'
#' @examples
#' df <- data.frame(
#' a = rnorm(5),
#' b = rnorm(5))
#' create_boxplot(df,"a","b")
create_boxplot <- function(data, x, y) {
  # first check if x and y exist in the data
  if (!x %in% colnames(data) || !y %in% colnames(data)) {
    stop("One or both of the inputted variables do not exist in the dataframe")
  }

  # make the box plot
  box <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(x), y = !!rlang::sym(y))) +
    ggplot2::geom_boxplot() +
    ggplot2::labs(
      title = paste("Box Plot of", x, "vs", y),
      x = x,
      y = y)

  # return the plot
  return(box)

  }
