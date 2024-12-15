#### Preamble ####
# Purpose: Tests the structure, data types, and validity of the simulated grocery prices dataset
# Author: Jiwon Choi
# Date: 14 November 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse` and `testthat` packages must be installed and loaded.
#   - The data cleaning script must have been run to clean the dataset.
#   - Ensure the dataset path is correct and accessible.
# Any other information needed? 
#   - This script is intended to validate the dataset by checking row and column counts, 
#     data types of each column, the presence of missing values, and specific data content rules 
#     (e.g., valid vendor names).
#   - Make sure you are in the correct project directory for file paths to work as expected.


#### Workspace setup ####
library(tidyverse)
library(testthat)

data <- read_csv("../data/02-analysis_data/cleaned_data.csv")


#### Test data ####
# Test that the dataset has 1694803 rows - there are 1694803 divisions in Australia
test_that("dataset has 1694803 rows", {
  expect_equal(nrow(analysis_data), 1694803)
})

# Test that the dataset has 8 columns
test_that("dataset has 8 columns", {
  expect_equal(ncol(analysis_data), 8)
})

# Test that 'nowtime' is double type (or POSIXct if converted to datetime)
test_that("'nowtime' is double or datetime type", {
  expect_type(simulated_data$nowtime, "double")  # Modify to "POSIXct" if `nowtime` is intended to be datetime
})

# Test that 'current_price' is character type
test_that("'current_price' is character", {
  expect_type(simulated_data$current_price, "character")
})

# Test that 'old_price' is character type
test_that("'old_price' is character", {
  expect_type(simulated_data$old_price, "character")
})

# Test that 'price_per_unit' is character type
test_that("'price_per_unit' is character", {
  expect_type(simulated_data$price_per_unit, "character")
})

# Test that 'vendor' is character type
test_that("'vendor' is character", {
  expect_type(simulated_data$vendor, "character")
})

# Test that 'product_name' is character type
test_that("'product_name' is character", {
  expect_type(simulated_data$product_name, "character")
})

# Test that 'units' is character type
test_that("'units' is character", {
  expect_type(simulated_data$units, "character")
})

# Test that 'product_id' is double type
test_that("'product_id' is double", {
  expect_type(simulated_data$product_id, "double")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(simulated_data)))
})

# Test that 'vendor' contains only valid vendor names
valid_vendors <- c("Metro", "Voila", "Loblaws", "Walmart", "NoFrills", "T&T", "Galleria", "Save-On-Foods")
test_that("'vendor' contains valid vendor names", {
  expect_true(all(simulated_data$vendor %in% valid_vendors))
})

# Test that there are no empty strings in 'vendor', 'product_name', and 'units' columns
test_that("no empty strings in 'vendor', 'product_name', or 'units' columns", {
  expect_false(any(simulated_data$vendor == "" | simulated_data$product_name == "" | simulated_data$units == ""))
})

# Test that 'current_price' contains at least 2 unique values
test_that("'current_price' column contains at least 2 unique values", {
  expect_true(length(unique(simulated_data$current_price)) >= 2)
})
