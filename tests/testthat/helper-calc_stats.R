# function input for tests
only_nums_2_obs <- data.frame(
  a = c(1:5),
  b = c(2:6),
  stringsAsFactors = FALSE)

only_char_data <- data.frame(
  fruits = c("Apple", "Banana", "Orange", "Grape"),
  cities = c("New York", "London", "Paris", "Tokyo"),
  stringsAsFactors = FALSE)

mixed_2_num <- data.frame(
  fruits = c("Apple", "Banana", "Orange", "Grape"),
  cities = c("New York", "London", "Paris", "Tokyo"),
  c = c(4:7),
  d = c(5:8),
  stringsAsFactors = FALSE)

int_data <- 5

# expected function outputs
only_nums_2_obs_output <- data.frame(
  a = c(mean(c(1:5)), sd(c(1:5)) ),
  b = c(mean(c(2:6)), sd(c(2:6)) ),
  row.names = c("Mean","SD"),
  stringsAsFactors = FALSE)

mixed_2_num_output <- data.frame(
  c = c(mean(c(4:7)), sd(c(4:7)) ),
  d = c(mean(c(5:8)), sd(c(5:8)) ),
  row.names = c("Mean","SD"),
  stringsAsFactors = FALSE)
