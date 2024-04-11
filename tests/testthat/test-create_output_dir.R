test_that("`create_output_dir` correctly creates the output directory when it does not exist", {
  create_output_dir(output_dir)
  expect_true(dir.exists(test_output_dir), info = "Output directory should be created")
})

test_that("`create_output_dir` should throw an error when incorrect types
are passed to `output_dir`", {
  expect_error(create_output_dir(int_data))
})
