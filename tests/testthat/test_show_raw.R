library(qicharts2)
context('Raw data display in xbar charts')

test_that('show.raw parameter works for xbar charts', {
  # Create test data with multiple observations per subgroup
  set.seed(123)
  n_subgroups <- 5
  subgroup_size <- 4
  
  test_data <- data.frame(
    subgroup = rep(1:n_subgroups, each = subgroup_size),
    value = rnorm(n_subgroups * subgroup_size, mean = 10, sd = 2)
  )
  
  # Test 1: Default behavior (show.raw = FALSE)
  p1 <- qic(subgroup, value, 
            data = test_data, 
            chart = 'xbar',
            show.raw = FALSE)
  
  expect_null(attr(p1$data, 'raw.data'))
  
  # Test 2: With show.raw = TRUE
  p2 <- qic(subgroup, value, 
            data = test_data, 
            chart = 'xbar',
            show.raw = TRUE)
  
  raw_data <- attr(p2$data, 'raw.data')
  expect_false(is.null(raw_data))
  expect_equal(nrow(raw_data), nrow(test_data))
  expect_true(all(c('x', 'y', 'facet1', 'facet2') %in% names(raw_data)))
  
  # Test 3: Verify raw data is not attached for non-xbar charts
  p3 <- qic(subgroup, value,
            data = test_data,
            chart = 'i',
            show.raw = TRUE)
  
  expect_null(attr(p3$data, 'raw.data'))
})

test_that('show.raw works with s charts', {
  # Create test data
  set.seed(456)
  test_data <- data.frame(
    subgroup = rep(1:5, each = 4),
    value = rnorm(20, mean = 10, sd = 2)
  )
  
  # Test with s chart
  p <- qic(subgroup, value, 
           data = test_data, 
           chart = 's',
           show.raw = TRUE)
  
  raw_data <- attr(p$data, 'raw.data')
  expect_false(is.null(raw_data))
  expect_equal(nrow(raw_data), nrow(test_data))
})

test_that('show.raw respects multiply parameter', {
  # Create test data
  set.seed(789)
  test_data <- data.frame(
    subgroup = rep(1:5, each = 4),
    value = rnorm(20, mean = 0.1, sd = 0.02)
  )
  
  # Test with multiply
  p <- qic(subgroup, value, 
           data = test_data, 
           chart = 'xbar',
           show.raw = TRUE,
           multiply = 100)
  
  raw_data <- attr(p$data, 'raw.data')
  expect_false(is.null(raw_data))
  
  # Check that raw data was multiplied
  original_max <- max(test_data$value, na.rm = TRUE)
  raw_max <- max(raw_data$y, na.rm = TRUE)
  expect_true(abs(raw_max - original_max * 100) < 1)
})
