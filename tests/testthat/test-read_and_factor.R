test_that("`read_and_factor` should return a dataframe", {
  expect_true((is.data.frame(read_and_factor(unfactored_populated_data_dir, valid_single_var))))
})

# test_that("`read_and_factor` is converting 1 variable to a factor", {
#   data <- readr::read_csv(unfactored_populated_data_dir) # read in the data from the input directory as we do in the function
#   data$cultivar <- factor(data$cultivar) # check the method we use in the function to convert it to a factor
#   expect_is(data$cultivar, "factor", info = "The 'cultivar' column should be converted into a factor")
# })
#
# test_that("`read_and_factor` is converting a valid variable vector to factors", {
#   data <- readr::read_csv(unfactored_populated_data_dir) # read in the data from the input directory as we do in the function
#   data$cultivar <- factor(data$cultivar) # check the method we use in the function to convert it to a factor
#   expect_is(data$cultivar, "factor", info = "The 'cultivar' column should be converted into a factor")
# })
#
# test_that("`read_and_factor` is converting a semi-valid variable vector to factors", {
#   data <- readr::read_csv(unfactored_populated_data_dir) # read in the data from the input directory as we do in the function
#   data$cultivar <- factor(data$cultivar) # check the method we use in the function to convert it to a factor
#   expect_is(data$cultivar, "factor", info = "The 'cultivar' column should be converted into a factor")
# })
#
# test_that("`read_and_factor` should throw an error for an invalid variable vector", {
#   data <- readr::read_csv(unfactored_populated_data_dir) # read in the data from the input directory as we do in the function
#   data$cultivar <- factor(data$cultivar) # check the method we use in the function to convert it to a factor
#   expect_is(data$cultivar, "factor", info = "The 'cultivar' column should be converted into a factor")
# })
#
# test_that("`read_and_factor` should throw an error for an invalid input directory", {
#   expect_error(read_and_factor(invalid_input_dir, valid_single_var))
# })
#
#
# test_that("`read_and_factor` should throw an error when incorrect types
# are passed to `input_dir` and `factor_vars`", {
#   expect_error(read_and_factor(int_data,output_dir))
#   expect_error(read_and_factor(unfactored_populated_data_dir,int_data))
# })
