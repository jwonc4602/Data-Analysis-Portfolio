#### Preamble ####
# Purpose: Cleans the raw data
# Author: Heyucheng Zhang, Jiwon Choi
# Date: 12 February 2024 
# Contact: heyucheng.zhang@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-simulate_data.R and 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(readxl)

#### Clean data ####

# Read data
unemployment <- read_excel("inputs/data/BLS_all_archived_counties7689aa (UNOFFICIAL).xlsx")
personal_income <- read_csv("inputs/data/CA1_1969_2013_ALL.csv")
bussiness <- read_csv("inputs/data/CA25_1969_2000_ALL.csv")

# Group unemployment data by state and year, calculating average for labor force, employed, unemployed, and unemployment rate
cleaned_unemployment <-
  unemployment |>
  group_by(state_name, year) |>
  summarise(
    average_labor_force = mean(laborforce, na.rm = TRUE),
    average_employed = mean(employed, na.rm = TRUE),
    average_unemployed = mean(unemployed, na.rm = TRUE),
    average_unemployment_rate = mean(unemployedrate, na.rm = TRUE)
  ) |>
  ungroup()

# Get records from New York, Florida, Texas, and California
cleaned_four_states <-
  cleaned_unemployment |>
  filter(state_name %in% c("New York", "Florida", "Texas", "California"))

cleaned_personal_income <-
  personal_income |>
  # Get records for the United States
  filter(GeoName == "United States") |>
  # Filter for the description of "Per capita personal income (dollars) 2/"
  filter(Description == "Per capita personal income (dollars) 2/") |>
  # Select the Description column and the year columns from 1976 to 2013
  select(Description, `1976`:`2013`) |>
  # Swap rows and columns
  gather(key = "year", value = "value", -Description) |>
  spread(key = "Description", value = "value")

cleaned_bussiness_pattern1 <-
  bussiness |>
  # Get records for the United States
  filter(GeoName == "United States") |>
  # Filter for the description of "Total full-time and part-time employment", "Wage and salary employment", "Proprietors employment"
  filter(Description %in% c("Total full-time and part-time employment", "Wage and salary employment", "Proprietors employment")) |>
  # select the Description column and the year columns from 1969 to 2000
  select(Description, `1969`:`2000`) |>
  # Swap rows and columns
  gather(key = "year", value = "value", -Description) |>
  spread(key = "Description", value = "value") |>
  # Order columns
  select("year", "Total full-time and part-time employment", "Wage and salary employment", "Proprietors employment")

cleaned_bussiness_pattern2 <-
  bussiness |>
  # Get records for the United States
  filter(GeoName == "United States") |>
  # Filter for the description of "Private nonfarm employment", "Agricultural services, forestry, and fishing", "Mining", "Construction", "Manufacturing", "Transportation and public utilities", "Wholesale trade", "Retail trade", "Finance, insurance, and real estate", "Services"
  filter(Description %in% c("Private nonfarm employment", "Agricultural services, forestry, and fishing", "Mining", "Construction", "Manufacturing", "Transportation and public utilities", "Wholesale trade", "Retail trade", "Finance, insurance, and real estate", "Services")) |>
  # select the Description column and the year columns from 1969 to 2000
  select(Description, `1969`:`2000`) |>
  # Swap rows and columns
  gather(key = "year", value = "value", -Description) |>
  spread(key = "Description", value = "value") |>
  # Order columns
  select("year", "Private nonfarm employment", "Agricultural services, forestry, and fishing", "Mining", "Construction", "Manufacturing", "Transportation and public utilities", "Wholesale trade", "Retail trade", "Finance, insurance, and real estate", "Services")

#### Save data ####
write_csv(cleaned_unemployment, "outputs/data/cleaned_unemployment.csv")
write_csv(cleaned_four_states, "outputs/data/cleaned_four_states.csv")
write_csv(cleaned_personal_income, "outputs/data/cleaned_personal_income.csv")
write_csv(cleaned_bussiness_pattern1, "outputs/data/cleaned_bussiness_pattern1.csv")
write_csv(cleaned_bussiness_pattern2, "outputs/data/cleaned_bussiness_pattern2.csv")


