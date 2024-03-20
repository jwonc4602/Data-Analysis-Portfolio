#### Preamble ####
# Purpose: Tests the cleaned data sets from "data/analysis_data/ns20191003_cleaned.csv", which is the survey data
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: scripts/01-download_data.R, scripts/survey02-data_cleaning-survey.R

### Test for the cleaned survey data ###
cleaned_data_survey <- read_csv("data/analysis_data/ns20191003_cleaned.csv")

# Check unique values for 'vote_intention'
valid_vote_intention <- c("Yes", "No", "Other")
all(cleaned_data_survey$vote_intention %in% valid_vote_intention)

# Check unique values for 'consider_trump'
valid_consider_trump <- c("Yes", "No", "Other")
all(cleaned_data_survey$consider_trump %in% valid_consider_trump)

# Check unique values for 'not_trump'
valid_not_trump <- c("Yes", "No", "Other")
all(cleaned_data_survey$not_trump %in% valid_not_trump)

# Check unique values for 'primary_party'
valid_primary_party <- c("Democratic", "Republican", "Other")
all(cleaned_data_survey$primary_party %in% valid_primary_party)

# Check unique values for 'education'
valid_education <- c("High school or less", "Some college", "College degree", "Postgrad", "Other")
all(cleaned_data_survey$education %in% valid_education)

# Check unique values for 'race_ethnicity'
valid_race_ethnicity <- c("White", "Black", "American Indian", "Asian", "Other")
all(cleaned_data_survey$race %in% valid_race_ethnicity)

# Check unique values for 'age_group'
valid_age_group <- c("18-29", "30-49", "50-69", "70+")
all(cleaned_data_survey$age_group %in% valid_age_group)

# Check unique values for 'gender'
valid_gender <- c("Female", "Male", "Unknown") # Including 'Unknown' if it was intentionally retained
all(cleaned_data_survey$gender %in% valid_gender)

# Ensure no 'Unknown' values in key columns
!any(cleaned_data_survey$vote_intention == "Unknown" |
       cleaned_data_survey$consider_trump == "Unknown" |
       cleaned_data_survey$not_trump == "Unknown" |
       cleaned_data_survey$primary_party == "Unknown" |
       cleaned_data_survey$education == "Unknown" |
       cleaned_data_survey$race == "Unknown" |
       cleaned_data_survey$age_group == "Unknown" |
       cleaned_data_survey$gender == "Unknown")

#### Test result ####
# Result: All TRUE
