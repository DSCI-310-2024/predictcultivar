#' Simplifies the workflow for fitting and training a knn model
#'
#' @param data The dataset to be split into training and testing sets
#' @param num_folds The desired number of folds to use for cross validation
#' @param response The response variable
#' @param range_neighbors A sequence of the desired values of k
#'
#' @return a fitted model
#' @export
#'
#' @examples
#' data <- data.frame(
#' a = rnorm(1000),
#' b = rnorm(1000),
#' cultivar = sample(c(1,2,3), 1000, replace = TRUE)
#' )
#' num_folds <- 5
#' range_neighbors <- seq(1, 20)
#' response <- "cultivar"
#' model_workflow(data, num_folds, range_neighbors, response)
model_workflow <- function(data, num_folds, range_neighbors, response) {
  # Split data into train and test sets
  set.seed(123)

  # Check the correct input types are provided
  if ((!is.data.frame(data)) || (!is.numeric(num_folds)) || (!is.numeric(range_neighbors))) {
    stop("Incorrect input types were given")
  }

  # Ensure the response is a variable in the dataframe
  if (!response %in% colnames(data)) {
    stop("The response variable does not exist in the dataframe")
  }
  # data[[response]]
  # [[response]]

  split <- rsample::initial_split(data, prop = 0.75, strata = response)
  train_data <- rsample::training(split)
  test_data <- rsample::testing(split)
  train_data[[response]] <- as.factor(train_data[[response]])
  test_data[[response]] <- factor(test_data[[response]])

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

  # Control grid for saving workflow and predictions:
  ctrl <- tune::control_grid(save_workflow = TRUE, save_pred = TRUE)

  # Model tuning:
  fit <- workflows::workflow() |>
    workflows::add_recipe(recipe) |>
    workflows::add_model(knn_spec) |>
    tune::tune_grid(resamples = folds, grid = grid_vals, control = ctrl)

  # Extracting best model configuration:
  best_model <- tune::fit_best(fit)

  # Making predictions with the best model:
  predictions <- stats::predict(best_model, new_data = test_data)

  # Extract the labels as a vector to pass to the confusion matrix
  predicted_labels <- predictions$.pred_class

  # Create a confusion matrix
  conf_matrix <- caret::confusionMatrix(data=predicted_labels, reference=test_data[[response]])

  # Get the values to pass to the helper function summarize_classes()
  stats_from_conf_matrix <- conf_matrix[[4]]
  num_classes <- nlevels(test_data[[response]])

  # Calculate accuracy, precision, f1, recall using the helper function summarize_classes()
  accuracy <- conf_matrix$overall["Accuracy"]
  recall <- predictcultivar::summarize_classes(stats_from_conf_matrix,num_classes,"Recall")
  precision <- predictcultivar::summarize_classes(stats_from_conf_matrix,num_classes,"Precision")
  f1 <- predictcultivar::summarize_classes(stats_from_conf_matrix,num_classes,"F1")


  # Store metrics in a dataframe
  metrics_df <- data.frame(
    Accuracy = accuracy,
    Precision = precision,
    Recall = recall,
    F1_Score = f1
  )

  # Return the confusion matrix and the dataframe of metrics
  return(list(cmat = conf_matrix, metrics = metrics_df))
}




# This is a helper function
#' Calculate model metrics given a confusion matrix. Useful for non-binary matricies
#'
#' @param all_metric_stats A matrix taken from a confusion matrix of all the stats
#' @param num_classes The number of classes in the matrix
#' @param metric The metric to calculate the average for
#'
#' @return a double
#' @export
#'
#' @examples
#' sample_stats <- c(0.3678161, 0.7134146, 0.4050633,
#' 0.6802326, 0.4050633, 0.3678161,
#' 0.3855422, 0.3466135, 0.3690476,
#' 0.6107784, 0.3229167, 0.6580645,
#' 0.3229167, 0.3690476, 0.3444444,
#' 0.3346614, 0.3000000, 0.6959064,
#' 0.3157895, 0.6800000, 0.3157895,
#' 0.3000000, 0.3076923, 0.3187251,
#' 0.12749004, 0.3147410, 0.5406154,
#' 0.12350598, 0.3824701, 0.4899130,
#' 0.09561753, 0.3027888, 0.4979532)
#' summarize_classes(sample_stats,3,"Sensitivity")
summarize_classes <- function(all_metric_stats,num_classes,metric) {
  # Assign a number to use for calculating indexes based on the metric
  if(metric == "Sensitivity"){
    metric_num <- 1
  } else if (metric == "Specificity") {
    metric_num <- 2
  } else if (metric == "Pos Pred Value") {
    metric_num <- 3
  } else if (metric == "Neg Pred Value") {
    metric_num <- 4
  } else if (metric == "Precision") {
    metric_num <- 5
  } else if (metric == "Recall") {
    metric_num <- 6
  } else if (metric == "F1") {
    metric_num <- 7
  } else if (metric == "Prevalence") {
    metric_num <- 8
  } else if (metric == "Detection Rate") {
    metric_num <- 9
  } else if (metric == "Detection Prevalence") {
    metric_num <- 10
  } else {
    metric_num <- 11
  }

  # Calculate the index where the values for the metric are located
  start_index <- (num_classes * (metric_num - 1)) + 1
  end_index <- start_index + num_classes - 1
  sum_metric <- 0

  # Iteratively sum the values for the metric
  for(index in start_index:end_index) {
    sum_metric <- sum_metric + all_metric_stats[index]
  }

  # Calculate the average value for the metric
  avg_metric <- sum_metric / num_classes

  return(avg_metric)
}
