wine_test_data <- data.frame(
  alcohol = c(12, 13, 14, 15),
  total_phenols = c(2, 3, 4, 5),
  cultivar = c("A", "B", "A", "C")
)

temp_dir <- tempdir()
wine_data_fake <- "this is not a data frame"
