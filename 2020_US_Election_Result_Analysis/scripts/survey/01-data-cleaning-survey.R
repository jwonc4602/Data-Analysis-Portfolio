#### Preamble ####
# Purpose: Cleans the raw survey data
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: scripts/01-download_data.R

#### Workspace setup ####
library(haven)
library(tidyverse)
library(dplyr)

# Load survey data
survey_data <- read_dta("data/raw_data/ns20191003/ns20191003.dta")

# Cleaning and modifying data: including gender categorization
cleaned_data_survey <- survey_data %>%
  select(vote_intention, consider_trump, not_trump, primary_party, education, state, race_ethnicity, age, gender) %>%
  mutate(
    vote_intention = case_when(
      vote_intention == 1 ~ "Yes",
      vote_intention == 2 ~ "No",
      vote_intention == 3 | vote_intention == 999 ~ "Other",
      TRUE ~ "Unknown"
    ),
    consider_trump = case_when(
      consider_trump == 1 ~ "Yes",
      consider_trump == 2 ~ "No",
      consider_trump == 999 ~ "Other",
      TRUE ~ as.character(consider_trump)
    ),
    not_trump = case_when(
      not_trump == 1 ~ "Yes",
      not_trump == 2 ~ "No",
      not_trump == 888 | not_trump == 999 ~ "Other",
      TRUE ~ "Unknown"
    ),
    primary_party = case_when(
      primary_party == 1 ~ "Democratic",
      primary_party == 2 ~ "Republican",
      primary_party == 3 | primary_party == 999 ~ "Other",
      TRUE ~ "Unknown"
    ),
    education = case_when(
      education %in% 1:4 ~ "High school or less",
      education %in% 5:7 ~ "Some college",
      education == 8 ~ "College degree",
      education %in% 9:11 ~ "Postgrad",
      TRUE ~ "Other"
    ),
    race_ethnicity = case_when(
      race_ethnicity == 1 ~ "White",
      race_ethnicity == 2 ~ "Black",
      race_ethnicity %in% 3 ~ "American Indian",
      race_ethnicity %in% 4:10 ~ "Asian",
      race_ethnicity %in% 11:14 ~ "Other",
      race_ethnicity == 15 ~ "Other",
      TRUE ~ "Unknown"
    ),
    age_group = case_when(
      age >= 18 & age <= 29 ~ "18-29",
      age >= 30 & age <= 49 ~ "30-49",
      age >= 50 & age <= 64 ~ "50-69",
      age >= 70 ~ "70+",
      TRUE ~ "Unknown" # Handles any missing or unexpected age values
    ),
    gender = case_when(
      gender == 1 ~ "Female",
      gender == 2 ~ "Male",
      TRUE ~ "Unknown" # Handles any other cases as "Unknown"
    )
  ) %>%
  rename(race = race_ethnicity) %>%
  select(-age) %>%
  # Filter step to remove rows with "Unknown" in any of the transformed columns
  filter(!if_any(c(vote_intention, consider_trump, not_trump, primary_party, education, state, race, age_group, gender), ~ .x == "Unknown"))

# Save the cleaned data
write_csv(cleaned_data_survey, "data/analysis_data/ns20191003_cleaned.csv")

