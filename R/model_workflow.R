#' Simplifies the workflow for fitting and training a knn model
#'
#' @param train_data The training dataset
#' @param num_folds The desired number of folds to use for cross validation
#' @param range_neighbors A sequence of the desired values of k
#' @param response The response variable to use in the model's formula
#'
#' @return a fitted model
#' @export
#'
#' @examples
#' set.seed(123)
#' train_data <- data.frame(
#' a = rnorm(100),
#' b = rnorm(100),
#' response = sample(c('a', 'b', 'c'), 100, replace = TRUE)
#' )
#' num_folds <- 5
#' range_neighbors <- seq(1, 20)
#' response <- "response"
#' model_workflow(train_data,num_folds, range_neighbors, response)
model_workflow <- function(train_data, num_folds, range_neighbors, response) {
  # Preprocessing:
  recipe <- recipes::recipe(as.formula(paste(response, "~ .")), data = train_data) |>
    recipes::step_scale(recipes::all_predictors()) |>
    recipes::step_center(recipes::all_predictors())

  # KNN model:
  knn_spec <- parsnip::nearest_neighbor(weight_func = "rectangular", neighbors = parsnip::tune()) |>
    parsnip::set_engine("kknn") |>
    parsnip::set_mode("classification")

  # Grid of neighbor values to tune over:
  grid_vals <- tibble::tibble(neighbors = range_neighbors)

  # Cross-validation setup:
  folds <- rsample::vfold_cv(train_data, v = num_folds, strata = response)

  # Model tuning:
  fit <- workflows::workflow() |>
    workflows::add_recipe(recipe) |>
    workflows::add_model(knn_spec) |>
    tune::tune_grid(resamples = folds, grid = grid_vals) |>
    tune::collect_metrics()

  # Filter for accuracy metric:
  accuracies <- fit |>
    dplyr::filter(.metric == "accuracy")

  # Determine the best number of neighbors based on accuracy:
  best_k <- accuracies |>
    dplyr::arrange(dplyr::desc(mean)) |>
    dplyr::slice(1) |>
    dplyr::pull(neighbors)

  return(list(fitted_model = fit, best_k = best_k, accuracies = accuracies))
}
