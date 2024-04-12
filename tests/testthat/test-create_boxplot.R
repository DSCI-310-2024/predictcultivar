library(testthat)
library(caret)
library(pandoc)


# Test that the function throws an error for incorrect input types
test_that("`create_boxplot` should throw an error for incorrect input types", {
  expect_error(create_boxplot(wine_data_fake,"cultivar", "alcohol"))
  expect_error(create_boxplot(wine_test_data,"cultivar", "fake_variable"))
})



# Test that the function is returning a ggplot object
test_that("`create_boxplot` should return a ggplot", {
  box_plot <- create_boxplot(wine_test_data, "alcohol", "total_phenols") # call the function
  expect_true("ggplot" %in% class(box_plot), info = "Should return a ggplot object") # expect class to be ggplot
})



# Test that the correct data is being plotted on the axes
test_that("`create_boxplot` correctly maps data to x axis", {
  box_plot <- create_boxplot(wine_test_data, "cultivar", "alcohol")
  x_aes <- ggplot2::ggplot_build(box_plot)$data[[1]]$x # Convert to factor and isolate the levels

  # Compare factor levels of x-axis data
  expect_equal(levels(x_aes), levels(wine_test_data$cultivar),
               info = "X-axis data should have the same levels as 'cultivar' column")
})


# Test that the axis labels have been created correctly
test_that("`create_boxplot` has the correct axis labels", {
  box_plot <- create_boxplot(wine_test_data, "cultivar", "alcohol") # make the Boxplot
  expect_equal(ggplot2::ggtitle("Box Plot of x vs y"), ggplot2::ggtitle("Box Plot of x vs y"), info = "Plot title should be correct")
  expect_equal(ggplot2::xlab("cultivar"), ggplot2::xlab("cultivar"), info = "X-axis label should be set to 'cultivar'")
  expect_equal(ggplot2::ylab("alcohol"), ggplot2::ylab("alcohol"), info = "Y-axis label should be set to 'alcohol'")
})
