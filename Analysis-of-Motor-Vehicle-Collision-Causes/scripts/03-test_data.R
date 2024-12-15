#### Preamble ####
# Purpose: Tests the cleaned dataset for traffic accident analysis
# Author: Jiwon Choi
# Date: 19 September 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download.R, 02-data_cleaning.R

#### Workspace setup ####
library(tidyverse)

# Read the finalized data
finalized_accident_data <- read_csv("data/analysis_data/total_cleaned_data.csv")

#### Data Cleaning ####
# Remove leading/trailing spaces in relevant columns
finalized_accident_data <- finalized_accident_data %>%
  mutate(across(everything(), trimws))  # Remove spaces in all columns

#### Initialize test results ####
test_results <- list()

#### Test unique values for categorical columns ####

# Test 1: 'traffctl' categories
expected_traffic_control_types <- c("No Control", "Traffic Signal", "Others")
test_results$test_1 <- all(unique(finalized_accident_data$traffctl) %in% expected_traffic_control_types)

# Test 2: 'visibility' categories
expected_visibility <- c("Clear", "Disturbed")
test_results$test_2 <- all(unique(finalized_accident_data$visibility) %in% expected_visibility)

# Test 3: 'light' categories
expected_light <- c("Dark", "Dim Light", "Daylight")
test_results$test_3 <- all(unique(finalized_accident_data$light) %in% expected_light)

# Test 4: 'rdsfcond' categories
expected_road_surface_conditions <- c("Dry", "Wet", "Others")
test_results$test_4 <- all(unique(finalized_accident_data$rdsfcond) %in% expected_road_surface_conditions)

# Test 5: 'acclass' categories
expected_classifications <- c("Fatal", "Non-Fatal Injury", "None or Others")
test_results$test_5 <- all(unique(finalized_accident_data$acclass) %in% expected_classifications)

# Test 6: 'speeding' categories
expected_speeding <- c("None", "Yes")
test_results$test_6 <- all(unique(finalized_accident_data$speeding) %in% expected_speeding)

# Test 7: 'ag_driv' categories
expected_aggressive_driving <- c("None", "Yes")
test_results$test_7 <- all(unique(finalized_accident_data$ag_driv) %in% expected_aggressive_driving)

# Test 8: 'alcohol' categories
expected_alcohol <- c("None", "Yes")
test_results$test_8 <- all(unique(finalized_accident_data$alcohol) %in% expected_alcohol)

# Test 9: 'disability' categories
expected_disability <- c("None", "Yes")
test_results$test_9 <- all(unique(finalized_accident_data$disability) %in% expected_disability)

# Test 10: 'date' format
# Check if the 'date' column is in the correct format 'YYYY-MM-DD'
is_valid_date <- function(date_column) {
  all(!is.na(as.Date(date_column, format = "%Y-%m-%d")))
}

test_results$test_10 <- is_valid_date(finalized_accident_data$date)

print(test_results)

