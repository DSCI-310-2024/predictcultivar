
<!-- README.md is generated from README.Rmd. Please edit that file -->

# predictcultivar

<!-- badges: start -->
[![codecov](https://codecov.io/gh/DSCI-310-2024/predictcultivar/graph/badge.svg?token=IwIVq9czpq)](https://codecov.io/gh/DSCI-310-2024/predictcultivar)
<!-- badges: end -->

The goal of predictcultivar is to help predict the category of unknown objects based on their properties. Here, we used it to predict wine cultivars, but it can be applied widely beyond this. 

## Installation

You can install the development version of predictcultivar from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DSCI-310-2024/predictcultivar")
```

## Usage

## 1. load_w_new_col()

Loading a dataset from an URL and changing its column names:
When you want to load an online dataset from an URL and at the same time change the names of the columns, usually you have to first load the data and then subsequently change the column names. However, with pRedictwine, you can do it all with a single function with load_W_new_col().

```{r}
dataset_url <- "https://raw.githubusercontent.com/plotly/datasets/master/mtcars.csv"

new_col_names <- c("model", "milespergallon", "cylinder_number", "displacement", "horsepower", "rear_axle_ratio", "weight", "quartermiletime", "engine", "transmission", "forwardgears", "carb")

comma_delimiter <- ","

loaded_dataset <- load_w_new_col(dataset_url, new_col_names, comma_delimiter)

# head() loads the first 6 rows of the tibble
head(loaded_dataset)
```

Note that the output is a tibble, and as https://tibble.tidyverse.org/ describes it, it is a "modern reimagining of the data frame". 

## 2. create_histogram()

If you want to create a histogram with x labels, different coloured values by group, and specifiable x-axis, y-axis, labels; you can do so with create_histogram(). Usually, with ggplot2, multiple layers have to be specified but with create_histogram(), it is possible to do so in a single function.

Here we show an example through the mtcars dataset. This will load a histogram for the "mpg" values, colored by "am" group. We have specified the x label to be "Miles/(US) gallon", the y label to be "Count", and the font size to be 10.

```{r, include = FALSE}
library(dplyr)

mtcars_mutated <- mtcars %>%
  dplyr::mutate(am = as.factor(am))
```

```{r}
mpghistogram <- create_histogram(df = mtcars_mutated, x = mpg, group = am,
                  x_lab = "Miles/(US) gallon", y_lab = "Count", font_size = 10)

mpghistogram
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(predictcultivar)
## basic example code
```


