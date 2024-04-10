#' Create a scatter plot
#'
#' @param data A dataframe containing the data to plot.
#' @param x A variable in the dataframe that will be on the plot's x axis.
#' @param y A variable in the dataframe that will be on the plot's y axis.
#' @param color_var A variable in the dataframe that will be used to color the points on the plot.
#'
#' @return a scatterplot
#' @export
#'
#' @examples
#' df <- data.frame(
#' a = rnorm(5),
#' b = rnorm(5),
#' c = rnorm(5))
#' create_scatter(df,"a","b","c")
create_scatter <- function(data, x, y, color_var) {
  # first check if x and y exist in the data
  if (!x %in% colnames(data) || !y %in% colnames(data)) {
    stop("One or both of the inputted variables do not exist in the dataframe")
  }

  # make the scatter plot
  scatter <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(x), y = !!rlang::sym(y), color = !!rlang::sym(color_var))) +
    ggplot2::geom_point() +
    ggplot2::labs(
      title = paste("Scatter Plot of", x, "vs", y),
      x = x,
      y = y)

  # Return the plot
  return(scatter)

}
