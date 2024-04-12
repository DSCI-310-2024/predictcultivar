# function input for tests
existing_file_and_input_dir <- "data/unfactored_populated_data.csv"
non_existing_input_dir <- "invalid/input/dir"
non_existing_file <- "~/predictcultivar/tests/testthat/data/fruits.csv"
invalid_input_dir <- 5

invalid_single_factor_vars_type <- 1
invalid_vector_factor_vars_type <- c(1,2,3)

valid_single_factor_vars <- "cultivar"
valid_vector_factor_vars <- c("cultivar", "alcohol")

non_existing_single_var <- "chicken"
one_non_existing_in_vector_factor_vars <- c("chicken", "alcohol")
all_non_existing_in_vector_factor_vars <- c("chicken", "can")
