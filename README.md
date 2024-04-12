
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

## Introduction to  `predictcultivar`
Welcome to our package! It was designed to streamline our data analysis project and produce code that can be easily used by others. This package contains 6 functions to take your project from Exploratory Data Analysis to finished, tuned `knn` model.

### Data: 
To demonstrate the package, we will use the dataset `mtcars` in R. 

```{r load-mtcars, echo=FALSE}
# Load the mtcars dataset
data(mtcars)

# Display the first few rows of the dataset
head(mtcars)

#>                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

This dataset contains information about 32 cars, such as their weight (`wt`) and fuel consumption (`mpg`). For this demonstration, we will aim to predict what type of transmission a car has (automatic or manual) based on `wt` and `mpg`. 

### Calculate summary statistics with `calc_stats()`
This function allows you to calculate the mean and standard deviation for all numerical columns in a dataframe.

```{r}
calc_stats(mtcars)
```
### Create boxplots with `create_boxplot()`
This function produces a boxplot based on the data and variables it is given.

```{r}
create_boxplot(mtcars,"wt","mpg")
```

The function takes the variable names as strings.


### Create scatterplots with `create_scatter()`
This function produces a scatterplot of `x` versus `y`, with the points coloured according to the variable in `color_var`.

```{r}
create_scatter(mtcars,"wt","mpg","am")
```

The function takes the variable names as strings.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(predictcultivar)
## basic example code
```


