# function input for create_output_dir function
library(ggplot2)

# test wine data
wine_test_data <- data.frame(
  alcohol = c(12, 13, 14, 15),
  total_phenols = c(2, 3, 4, 5),
  cultivar = c("A", "B", "A", "C")
)

# create fake wine data
wine_data_fake <- "a"

# expected output
expected_plot <- ggplot() +
  geom_point() +
  labs(
    title = "Scatter Plot of alcohol vs total_phenols",
    x = "alcohol",
    y = "total_phenols"
  )
