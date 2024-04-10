# test that the function is returning a ggplot object
test_that("`create_scatter` should return a ggplot", {
  scatter_plot <- create_scatter(wine_test_data, "alcohol", "total_phenols", "cultivar") # call the function
  expect_true("ggplot" %in% class(scatter_plot), info = "Should return a ggplot object") # expect class to be ggplot
})

# test that the correct types of variables are being inputted into the function
test_that("`create_scatter` should throw an error when incorrect types
are passed to `data`, `scatter1`, and `scatter2` arguments", {
  expect_error(create_scatter(wine_data_fake, "alcohol", "total_phenols", "cultivar"), info = "Dataframe should be inputted")
  expect_error(create_scatter(wine_test_data, "variable1", "total_phenols", "cultivar"), info = "Valid x variable should be inputted")
  expect_error(create_scatter(wine_test_data, "alcohol", "variable2", "cultivar"), info = "Valid y variable should be inputted")
})

# test that the correct data is being plotted on the axes
test_that("`create_scatter` correctly maps data to x and y axes", {
  scatter_plot <- create_scatter(wine_test_data, "alcohol", "total_phenols", "cultivar")
  x_aes <- ggplot2::ggplot_build(scatter_plot)$data[[1]]$x # isolate the values on the x-axis
  y_aes <- ggplot2::ggplot_build(scatter_plot)$data[[1]]$y # isolate the values on the y-axis
  expect_equal(x_aes, wine_test_data$alcohol, info = "X-axis data should match 'alcohol' column")
  expect_equal(y_aes, wine_test_data$total_phenols, info = "Y-axis data should match 'total_phenols' column")
})

# test that the axis labels have been created correctly
test_that("`create_scatter` has the correct axis labels", {
  scatter_plot <- create_scatter(wine_test_data, "alcohol", "total_phenols", "cultivar") # make the scatterplot
  expect_equal(ggplot2::ggtitle("Scatter Plot of x vs y"), ggtitle("Scatter Plot of x vs y"), info = "Plot title should be correct")
  expect_equal(ggplot2::xlab("alcohol"), ggplot2::xlab("alcohol"), info = "X-axis label should be set to 'alcohol'")
  expect_equal(ggplot2::ylab("total_phenols"), ggplot2::ylab("total_phenols"), info = "Y-axis label should be set to 'total_phenols'")
})

# make sure the same cultivars are colored the same color
test_that("`create_scatter` colors points with the same cultivar the same color", {
  scatter_plot <- create_scatter(wine_test_data, "alcohol", "total_phenols", "cultivar") # create the scatterplot
  color_aes <- ggplot2::ggplot_build(scatter_plot)$data[[1]]$colour # isolate the values for colour
  unique_cultivars <- unique(wine_test_data$cultivar) # get a list of the unique cultivars in our data

  # for loop to check that the cultivars have the same color if they have the same value
  for (cultivar in unique_cultivars) {
    points_with_cultivar <- which(wine_test_data$cultivar == cultivar)
    color_for_cultivar <- color_aes[points_with_cultivar[1]]
    expect_true(all(color_aes[points_with_cultivar] == color_for_cultivar),
                info = paste("Points with cultivar", cultivar, "should be colored the same"))
  }
})

# make sure different cultivars are colored different colors
test_that("`create_scatter` assigns different colors to different cultivars", {
  scatter_plot <- create_scatter(wine_test_data, "alcohol", "total_phenols", "cultivar") # create the scatterplot
  color_aes <- ggplot2::ggplot_build(scatter_plot)$data[[1]]$colour # isolate the values from colour
  unique_cultivars <- unique(wine_test_data$cultivar) # get a list of the unique cultivars

  # make a for loop to get that the cultivars have different colors
  for (i in seq_along(unique_cultivars)) {
    points_with_cultivar <- which(wine_test_data$cultivar == unique_cultivars[i])
    color_for_cultivar <- color_aes[points_with_cultivar[1]]
    other_cultivars <- unique_cultivars[-i]
    expect_true(all(color_for_cultivar != color_aes[which(wine_test_data$cultivar %in% other_cultivars)]),
                info = paste("Points with cultivar", unique_cultivars[i], "should be assigned different colors"))
  }
})
