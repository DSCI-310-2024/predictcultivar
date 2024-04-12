library(testthat)
library(caret)
library(pandoc)

# Test that the function throws an error for incorrect input types
test_that("`read_and_factor` should throw an error when incorrect types
are passed to `input_dir` and `factor_vars`", {
  # valid(existing) input_dir, invalid single factor_vars
  expect_error(read_and_factor(existing_file_and_input_dir,invalid_single_factor_vars_type))
  # valid(existing) input_dir, invalid vector for factor_vars
  expect_error(read_and_factor(existing_file_and_input_dir,invalid_vector_factor_vars_type))
  # invalid input_dir, valid single factor_vars
  expect_error(read_and_factor(invalid_input_dir,valid_single_factor_vars))
  # invalid input_dir, valid vector for factor_vars
  expect_error(read_and_factor(invalid_input_dir,valid_vector_factor_vars))
  # both input_dir and factor_vars are invalid
  expect_error(read_and_factor(invalid_input_dir,invalid_single_factor_vars_type))
})

# Test that the function throws an error when the input directory or file does not exist, regardless of the second argument
test_that("`read_and_factor` should throw an error for a non existent input directory", {
  # input_dir does not exist
  expect_error(read_and_factor(non_existing_file_and_input_dir, valid_single_factor_vars))
  expect_error(read_and_factor(non_existing_file_and_input_dir, valid_vector_factor_vars))
  # input_dir exists but the file does not
  expect_error(read_and_factor(non_existing_file, valid_single_factor_vars))
  expect_error(read_and_factor(non_existing_file, valid_vector_factor_vars))
})

# Test that the function throws an error when the variable is not in the dataframe
test_that("`read_and_factor` should throw an warning when given a variable not in the dataframe", {
  # a single variable is passed, it is not in the dataframe
  expect_warning(read_and_factor(existing_file_and_input_dir, non_existing_single_var))
  # a vector of variables is passed, only one is not in the dataframe
  expect_warning(read_and_factor(existing_file_and_input_dir, one_non_existing_in_vector_factor_vars))
  # a vector of variables is passed, none are in the dataframe
  expect_warning(read_and_factor(existing_file_and_input_dir, all_non_existing_in_vector_factor_vars))
})


# Test that the function is returning a dataframe object when there is something to convert to a factor
test_that("`read_and_factor` should return a dataframe", {
  expect_true((is.data.frame(read_and_factor(existing_file_and_input_dir, valid_single_factor_vars))))
})

# Test that the function is returning a dataframe object when there isn't something to convert to a factor
test_that("`read_and_factor` should return a dataframe", {
  expect_true((is.data.frame(read_and_factor(existing_file_and_input_dir))))
})

# Test that a single variable is being converted to a factor
test_that("`read_and_factor` is converting 1 variable to a factor", {
  data_with_factors <- read_and_factor(existing_file_and_input_dir, valid_single_factor_vars)
  expect_true(is.factor(data_with_factors$cultivar))
})

# Test that all variables in a vector are being converted to factors
test_that("`read_and_factor` is converting a valid variable vector to factors", {
  data_with_all_factors <- read_and_factor(existing_file_and_input_dir, valid_vector_factor_vars)
  # iterate through all given variables to make sure they've all been factored
  for (var in valid_vector_factor_vars) {
    expect_true(is.factor(data_with_all_factors[[var]]))
  }
})

# Test that only existing variables in a vector are being converted to factors
test_that(
  "`read_and_factor` is converting a semi-valid variable vector to factors",
  {
    data_with_some_factors <-
      read_and_factor(existing_file_and_input_dir,
                      one_non_existing_in_vector_factor_vars)
    # iterate through all given variables existing in the dataframe to make sure they've all been factored
    for (var in one_non_existing_in_vector_factor_vars) {
      if (var %in% colnames(data_with_some_factors)) {
        expect_true(is.factor(data_with_some_factors[[var]]))
      }
    }
  })

