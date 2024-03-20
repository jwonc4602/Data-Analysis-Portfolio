#### Preamble ####
# Purpose: Model political vote intention using logistic regression.
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: need to have properly cleaned censusa data

# Load required libraries
library(tidyverse)
library(rstanarm)

# Load the trained logistic regression model
political_preferences <- readRDS("models/consider_trump.rds")

# Load the Census data
census_data <- read_csv("data/analysis_data/usa_00002_cleaned.csv")

# reduce the size of data due to memory limit
census_reduced <- 
  census_data |> 
  slice_sample(n = 100000)


# Use predict() to apply the model to the Census data
# Here, type = "response" gives probabilities, which is what we want
predictions <- predict(political_preferences, newdata = census_reduced, type = "response")

# Add these predictions to the census_data dataframe
census_reduced$predicted_consider_trump_probability <- predictions

# Save the updated census_data with predictions to an RDS file
saveRDS(census_reduced, file = "models/census_data_with_predictions.rds")

