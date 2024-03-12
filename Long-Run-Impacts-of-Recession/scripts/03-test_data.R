#### Preamble ####
# Purpose: Tests the cleaned data from "outputs/data/"
# Author: Heyucheng Zhang, Jiwon Choi
# Date: 12 February 2024 
# Contact: heyucheng.zhang@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-simulate_data.R，01-download_data.R and 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)

#### Test data ####

# Read data
cleaned_unemployment <- read_csv("outputs/data/cleaned_unemployment.csv")
cleaned_four_states <- read_csv("outputs/data/cleaned_four_states.csv")
cleaned_personal_income <- read_csv("outputs/data/cleaned_personal_income.csv")
cleaned_bussiness_pattern1 <- read_csv("outputs/data/cleaned_bussiness_pattern1.csv")
cleaned_bussiness_pattern2 <- read_csv("outputs/data/cleaned_bussiness_pattern2.csv")

# Test if there are 51 unique state name in the "state_name" column, note that "District of Columbia" is included in "state_name" column
cleaned_unemployment$state_name |>
  unique()|>
  length() == 51

# Test if the unique years in the cleaned_unemployment fall within the range from 1976 to 1989
cleaned_unemployment$year |>
  unique() == 1976:1989

# Test the unique values in the "state_name" column of cleaned_four_states are "California", "Florida", "New York", "Texas"
cleaned_four_states$state_name |>
  unique() ==  c("California", "Florida", "New York", "Texas")

# Test if the number of rows in the cleaned_four_states is equal to 4(states) x 14(years from 1976 to 1989)
nrow(cleaned_four_states) == 4 * 14

# Test if the number of rows in the cleaned_personal_income is equal to 38(years from 1976 to 2013))
nrow(cleaned_personal_income) == 38

# Test if the unique years in the cleaned_personal_income fall within the range from 1976 to 1989
cleaned_personal_income$year |>
  unique() == 1976:2013

# Test if the number of rows in the cleaned_bussiness_pattern1 is equal to 32(years from 1969 to 2000))
nrow(cleaned_bussiness_pattern1) == 32

# Test if the number of columns in the cleaned_bussiness_pattern1 is equal to 4("year", "Total full-time and part-time employment", "Wage and salary employment", "Proprietors employment")
length(cleaned_bussiness_pattern1) == 4

# Test if the unique years in the cleaned_bussiness_pattern1 fall within the range from 1969 to 2000
cleaned_bussiness_pattern1$year |>
  unique() == 1969:2000

# Test if the number of rows in the cleaned_bussiness_pattern2 is equal to 32(years from 1969 to 2000))
nrow(cleaned_bussiness_pattern2) == 32

# Test if the number of columns in the cleaned_bussiness_pattern2 is equal to 11("year", "Private nonfarm employment", "Agricultural services, forestry, and fishing", "Mining", "Construction", "Manufacturing", "Transportation and public utilities", "Wholesale trade", "Retail trade", "Finance, insurance, and real estate", "Services")
length(cleaned_bussiness_pattern2) == 11

# Test if the unique years in the cleaned_bussiness_pattern2 fall within the range from 1969 to 2000
cleaned_bussiness_pattern2$year |>
  unique() == 1969:2000

#### Test result ####
# Result: All TRUE