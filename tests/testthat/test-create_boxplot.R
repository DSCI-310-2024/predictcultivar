# Test that the function throws an error for incorrect input types
test_that("`create_boxplot` should throw an error for incorrect input types", {
  expect_error(create_boxplot(wine_data_fake,"cultivar", "alcohol"))
  expect_error(create_boxplot(wine_test_data,"cultivar", "fake_variable"))
})
