#' Creates a directory at the given path if it does not already exist
#'
#' @param output_dir The path to the output directory
#'
#' @export
#'
#' @examples
#' create_output_dir('../results/')
create_output_dir <- function(output_dir) {
  # create output_dir if it does not exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
  }
}
