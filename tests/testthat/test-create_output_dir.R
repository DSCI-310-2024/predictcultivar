library(testthat)
library(caret)
library(pandoc)


# Test that the function throws an error for incorrect input types
test_that("`create_output_dir` should throw an error when incorrect types
are passed to `output_dir`", {
  expect_error(create_output_dir(int_data))
})


# Test that the function creates the directory when there was none
test_that("`create_output_dir` correctly creates the output directory when it does not exist", {
  create_output_dir(new_output_dir)
  expect_true(dir.exists(test_output_dir), info = "Output directory should be created")
})

# Test that the directory is not modified when it already existed
test_that("create_output_dir does not modify existing directory", {
  # Set up a temporary directory for testing
  temp_dir <- tempfile()
  dir.create(temp_dir)

  # Get the modification time of the directory before calling the function
  modification_time_before <- file.info(temp_dir)$mtime

  # Call the function with the existing directory
  create_output_dir(temp_dir)

  # Get the modification time of the directory after calling the function
  modification_time_after <- file.info(temp_dir)$mtime

  # Assert that the directory still exists
  expect_true(dir.exists(temp_dir))

  # Assert that the modification time remains unchanged
  expect_equal(modification_time_before, modification_time_after)
})

