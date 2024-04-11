# function input for tests
unfactored_populated_data <- data.frame(
  alcohol = c(12, 13, 14),
  total_phenols = c(2, 3, 4),
  cultivar = c("A", "B", "A")
)
write.csv(unfactored_populated_data, "~/predictcultivar/tests/testthat/data/unfactored_populated_data.csv")
unfactored_populated_data_dir <- "~/predictcultivar/tests/testthat/data/unfactored_populated_data.csv"

valid_single_var <- "cultivar"
# valid_var_vector <- c("cultivar", "alcohol")
# invalid_single_var <- "chicken"
# one_invalid_in_2_var_vector <- c("chicken", "alcohol")
# all_invalid_in_2_var_vector <- c("chicken", "can")
#
# invalid_input_dir <- "invalid/input/dir"
# expected function outputs
