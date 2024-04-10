#' Create a scatter plot
#'
#' @param data A dataframe containing the data to plot.
#' @param scatter1 A variable in the dataframe that will be on the plot's x axis.
#' @param scatter2 A variable in the dataframe that will be on the plot's y axis.
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
create_scatter <- function(data, scatter1, scatter2, color_var) {
  # first check if scatter1 and scatter2 exist in the data
  if (!scatter1 %in% colnames(data) || !scatter2 %in% colnames(data)) {
    stop("One or both of the inputted variables do not exist in the dataframe")
  }

  # make the scatter plot
  scatter <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(scatter1), y = !!rlang::sym(scatter2), color = !!rlang::sym(color_var))) +
    ggplot2::geom_point() +
    ggplot2::labs(
      title = paste("Scatter Plot of", scatter1, "vs", scatter2),
      x = scatter1,
      y = scatter2)

  # Return the plot
  return(scatter)

}
