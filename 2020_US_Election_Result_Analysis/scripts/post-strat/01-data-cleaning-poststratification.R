#### Preamble ####
# Purpose: Cleans the raw post-strat data
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(haven)
library(tidyverse)
library(dplyr)

# Create the lookup vector for state postal abbreviations
state_abbreviations <- c(`1` = "CT", `2` = "ME", `3` = "MA",
                         `4` = "NH", `5` = "RI", `6` = "VT",
                         `11` = "DE", `12` = "NJ", `13` = "NY",
                         `14` = "PA", `21` = "IL", `22` = "IN",
                         `23` = "MI", `24` = "OH", `25` = "WI",
                         `31` = "IA", `32` = "KS", `33` = "MN",
                         `34` = "MO", `35` = "NE", `36` = "ND",
                         `37` = "SD", `40` = "VA", `41` = "AL",
                         `42` = "AR", `43` = "FL", `44` = "GA",
                         `45` = "LA", `46` = "MS", `47` = "NC",
                         `48` = "SC", `49` = "TX", `51` = "KY",
                         `52` = "MD", `53` = "OK", `54` = "TN",
                         `56` = "WV", `61` = "AZ", `62` = "CO",
                         `63` = "ID", `64` = "MT", `65` = "NV",
                         `66` = "NM", `67` = "UT", `68` = "WY",
                         `71` = "CA", `72` = "OR", `73` = "WA",
                         `81` = "AK", `82` = "HI", `83` = "PR",
                         `96` = "US", `97` = "MR", `98` = "DC",
                         `99` = "XX")

# Create the lookup vector for sex categories
sex_categories <- c(`1` = "Male", `2` = "Female", `9` = "Missing/blank")

#### Data cleaning for post-stratification data ####
raw_data <- read_dta("data/raw_data/usa_00002.dta")
cleaned_data <- raw_data %>%
  select(sex, age, race, educd, stateicp) %>%
  mutate(stateicp = state_abbreviations[as.character(stateicp)], # Replace state codes with abbreviations
         sex = sex_categories[as.character(sex)], # Replace sex codes with categories
         age_group = case_when(
           age >= 18 & age <= 29 ~ "18-29",
           age >= 30 & age <= 49 ~ "30-49",
           age >= 50 & age <= 64 ~ "50-69",
           age >= 70 ~ "70+",
           TRUE ~ "Unknown"
         ),
         race = case_when(
           race == 1 ~ "White",
           race == 2 ~ "Black",
           race == 3 ~ "American Indian",
           race %in% c(4, 5, 6) ~ "Asian",
           race %in% c(7, 8, 9) ~ "Other",
           TRUE ~ "Unknown"
         ),
         education = case_when(
           educd %in% c(0:60, 62, 63) ~ "High school or less",
           educd %in% c(64, 65:71, 73:80) ~ "Some college",
           educd %in% c(81, 82:113) ~ "College degree",
           educd >= 114 ~ "Postgrad",
           TRUE ~ "Unknown"
         )) %>%
  rename(state = stateicp, gender = sex) %>%
  select(-age, -educd) %>% # Remove the original 'age' and 'educd' columns to keep only the age group and education group
  # Filter step to remove rows with "Unknown" in any of the transformed columns
  filter(!if_any(c(gender, age_group, race, education), ~ .x == "Unknown"))

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/usa_00002_cleaned.csv")

