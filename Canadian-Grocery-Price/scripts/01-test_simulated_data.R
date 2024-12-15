#### Preamble ####
# Purpose: Tests the structure and validity of the simulated grocery prices dataset.
# Author: Jiwon Choi
# Date: 14 November 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - The data simulation script must have been run
# Make sure you are in the correct project directory


#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_grocery_data.csv", show_col_types = FALSE)

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 500 rows (or any specified size in `n_divisions`)
if (nrow(simulated_data) == 500) {
  message("Test Passed: The dataset has 500 rows.")
} else {
  stop("Test Failed: The dataset does not have 500 rows.")
}

# Check if the dataset has 8 columns
if (ncol(simulated_data) == 8) {
  message("Test Passed: The dataset has 8 columns.")
} else {
  stop("Test Failed: The dataset does not have 8 columns.")
}

# Check if all values in the 'product_id' column are unique
if (n_distinct(simulated_data$product_id) == nrow(simulated_data)) {
  message("Test Passed: All values in 'product_id' are unique.")
} else {
  stop("Test Failed: The 'product_id' column contains duplicate values.")
}

# Check if the 'vendor' column contains only valid vendor names
valid_vendors <- c("Metro", "Voila", "Loblaws", "Walmart", "NoFrills", "T&T", "Galleria", "Save-On-Foods")

if (all(simulated_data$vendor %in% valid_vendors)) {
  message("Test Passed: The 'vendor' column contains only valid vendor names.")
} else {
  stop("Test Failed: The 'vendor' column contains invalid vendor names.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'vendor', 'product_name', and 'units' columns
if (all(simulated_data$vendor != "" & simulated_data$product_name != "" & simulated_data$units != "")) {
  message("Test Passed: There are no empty strings in 'vendor', 'product_name', or 'units'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'current_price' and 'price_per_unit' columns are numeric and non-negative
if (is.numeric(simulated_data$current_price) && all(simulated_data$current_price >= 0)) {
  message("Test Passed: The 'current_price' column is numeric and non-negative.")
} else {
  stop("Test Failed: The 'current_price' column is not numeric or contains negative values.")
}

if (is.numeric(simulated_data$price_per_unit) && all(simulated_data$price_per_unit >= 0)) {
  message("Test Passed: The 'price_per_unit' column is numeric and non-negative.")
} else {
  stop("Test Failed: The 'price_per_unit' column is not numeric or contains negative values.")
}

# Check if the 'nowtime' column contains valid datetime values
if (all(lubridate::is.POSIXct(simulated_data$nowtime))) {
  message("Test Passed: The 'nowtime' column contains valid datetime values.")
} else {
  stop("Test Failed: The 'nowtime' column does not contain valid datetime values.")
}

# Check if the 'vendor' column has at least two unique values
if (n_distinct(simulated_data$vendor) >= 2) {
  message("Test Passed: The 'vendor' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'vendor' column contains less than two unique values.")
}
