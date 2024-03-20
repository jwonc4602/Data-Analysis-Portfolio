#### Preamble ####
# Purpose: Tests the cleaned data sets from "data/analysis_data/usa_00002_cleaned.csv", which is the post-strat data
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: scripts/01-download_data.R, scripts/post-strat/02-data_cleaning-post-strat.R

#### Workspace setup ####
library(tidyverse)
library(lubridate)

### Test for the cleaned post-strat data ###
cleaned_data <- read_csv("data/analysis_data/usa_00002_cleaned.csv")

# Check if 'state' contains only valid state abbreviations
all(cleaned_data$state %in% state_abbreviations)

# Check if 'gender' contains only valid categories
all(cleaned_data$gender %in% sex_categories)

# Check if 'age_group' is categorized correctly
valid_age_groups <- c("18-29", "30-49", "50-69", "70+")
all(cleaned_data$age_group %in% valid_age_groups)

# Check if 'race' is categorized correctly
valid_races <- c("White", "Black", "American Indian", "Asian", "Other")
all(cleaned_data$race %in% valid_races)

# Check if 'education' is categorized correctly
valid_education_levels <- c("High school or less", "Some college", "College degree", "Postgrad")
all(cleaned_data$education %in% valid_education_levels)

# Check for absence of 'Unknown' in key columns
!any(cleaned_data$gender == "Unknown" | cleaned_data$age_group == "Unknown" | cleaned_data$race == "Unknown" | cleaned_data$education == "Unknown")

# Ensure that original 'age' and 'educd' columns are removed
!"age" %in% names(cleaned_data)
!"educd" %in% names(cleaned_data)

# Applying is.character to each column and checking if all are TRUE
columns_to_check <- c("gender", "state", "race", "education", "age_group")
all(sapply(cleaned_data[columns_to_check], is.character))

#### Test result ####
# Result: All TRUE
