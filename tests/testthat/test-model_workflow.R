# Test that the function throws an error for incorrect input types
test_that("`model_workflow` should throw an error when incorrect types
are passed to the arguments", {
  # incorrect object for dataframe
  expect_error(model_workflow(not_a_df,num_folds_5, range_neighbors_20, response_cul))
  # one or more non-numeric arguments
  expect_error(model_workflow(wine_test_data,not_numeric, range_neighbors_20, response_cul))
  expect_error(model_workflow(wine_test_data,num_folds_5, not_numeric, response_cul))
  expect_error(model_workflow(wine_test_data,not_numeric, not_numeric, response_cul))
})

# Test that the function throws an error when the response variable does nto exist in the given data frame
test_that("`model_workflow` should throw an error when the response_cul variable does not exist" , {
  expect_error(model_workflow(not_a_df,wine_test_data, range_neighbors_20, non_existing_single_var))
})

# Test that the function is returning a list containing two elements
test_that("The right number of objects is returned", {
  results <- model_workflow(wine_test_data, num_folds_5, range_neighbors_20, "cultivar")
  expect_true(is.list(results))
  expect_equal(length(results), 2)
})



