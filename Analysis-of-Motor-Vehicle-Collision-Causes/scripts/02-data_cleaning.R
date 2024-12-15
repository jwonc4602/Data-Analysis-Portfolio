#### Preamble ####
# Purpose: Cleans and prepares the Motor Vehicle Collisions statistics data for analysis.
#          This script focuses on data downloaded from the OpenDataToronto portal, ensuring 
#          it's in the correct format and ready for further statistical analysis or visualization.
# Author: Jiwon Choi
# Date: 18 September 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(tidyr)
library(janitor)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Apply clean_names and select necessary columns
cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(date, traffctl, visibility, light, rdsfcond, acclass, speeding, ag_driv, alcohol, disability) |>
  tidyr::drop_na()

cleaned_data <- cleaned_data %>%
  mutate(traffctl = case_when(
    traffctl == "No Control" ~ "No Control",
    traffctl == "Traffic Signal" ~ "Traffic Signal",
    TRUE ~ "Others"
  ))

# Modify visibility to group categories into 'Clear' or 'Disturbed'
cleaned_data <- cleaned_data %>%
  mutate(visibility = case_when(
    visibility == "Clear" ~ "Clear",
    TRUE ~ "Disturbed"
  ))

# Modify light to group categories into 'Dark','Daylight', and 'Dim Light'
cleaned_data <- cleaned_data %>%
  mutate(light = case_when(
    light %in% c("Dark", "Dark, artificial") ~ "Dark",
    light %in% c("Daylight", "Daylight, artificial") ~ "Daylight",
    TRUE ~ "Dim Light"
  ))

# Modify rdsfcond to group categories into 'Dry', 'Wet', and 'Others'
cleaned_data <- cleaned_data %>%
  mutate(rdsfcond = case_when(
    rdsfcond == "Dry" ~ "Dry",
    rdsfcond == "Wet" ~ "Wet",
    TRUE ~ "Others"
  ))

cleaned_data <- cleaned_data %>%
  mutate(acclass = case_when(
    acclass == "Fatal" ~ "Fatal",
    acclass == "Non-Fatal Injury" ~ "Non-Fatal Injury",
    TRUE ~ "None or Others"
  ))

# human factors
human_factors_data <-
  cleaned_data |>
  janitor::clean_names() |>
  select(date, speeding, ag_driv, alcohol, disability) |>
  tidyr::drop_na()

# environmental factors
environmental_factors_data <-
  cleaned_data |>
  janitor::clean_names() |>
  select(date, traffctl, visibility, light, rdsfcond) |>
  tidyr::drop_na()

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/total_cleaned_data.csv")
write_csv(human_factors_data, "data/analysis_data/human_factors_data.csv")
write_csv(environmental_factors_data, "data/analysis_data/environmental_factors_data.csv")

