# function input for tests
# test data
wine_test_data <- read.csv("data/unfactored_populated_data.csv")
wine_test_data$cultivar <- factor(wine_test_data$cultivar)

# fake data
wine_data_fake <- "this is not a data frame"


# unfactored_populated_data <- data.frame(
#   total_phenols = rnorm(200),
#   alcohol = rnorm(200),
#   cultivar = sample(c(1,2,3), 200, replace = TRUE)
# )
