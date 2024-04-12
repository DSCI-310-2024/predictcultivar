library(caret)
library(pandoc)

# Test that the function throws an error for incorrect input types
test_that("`calc_stats.R` should throw an error when incorrect types
are passed to the `data`", {
  expect_error(calc_stats(int_data))
})

# Test that the function throws an error for when there are no numeric columns in the dataframe
test_that("`calc_stats.R` should throw an error when there are no numeric columns in `data`", {
  expect_error(calc_stats(only_char_data))
})



# Test that the function is returning a dataframe object
test_that("`calc_stats.R` should return a data frame with all the columns of 'data' as rows", {
  expect_equal(calc_stats(only_nums_2_obs), only_nums_2_obs_output, ignore_attr = TRUE)
})



# Test that all numeric columns are being summarized
test_that("`calc_stats.R` should return a dataframe with the number of rows that
          corresponds to the number of numeric columns in the dataframe passed to `data`", {
  expect_equal(calc_stats(mixed_2_num), mixed_2_num_output, ignore_attr = TRUE)
})

