test_that("Gets angry at numbers", {
  expect_error(make_colorvec(5))
})

test_that("Gets angry at multiple arguments", {
  expect_error(make_colvec(c("wolfe2014", "wolfe2012")))
})

test_that("Gets angry at non-supported palette", {
  expect_error(make_colvec(c("wooolfe2014")))
})
