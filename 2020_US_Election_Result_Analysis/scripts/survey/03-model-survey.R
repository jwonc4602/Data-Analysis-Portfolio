#### Preamble ####
# Purpose: Model political vote intention using logistic regression.
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: need to have properly cleaned survey data

#### Workspace setup ####
library(tidyverse)   # For data manipulation and visualization
library(rstanarm)    # For Bayesian models including logistic regression

#### Read data ####
survey_data <- read_csv("data/analysis_data/ns20191003_cleaned.csv")

set.seed(853)

survey_reduced <- 
  survey_data |> 
  slice_sample(n = 1000)

# Recode 'consider_trump' into a binary variable: 1 for 'Yes', 0 for 'No' and 'Other'
survey_data$consider_trump_binary <- ifelse(survey_data$consider_trump == "Yes", 1, 0)

# Fit the logistic regression model using the binary outcome variable
political_preferences <- stan_glm(
  consider_trump_binary ~ gender + education + age_group + race + state,
  data = survey_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853,
  # Increased iteration values due to warning message that indicates Bulk Effective Samples Size (ESS) 
  # and Tail Effective Samples Size (ESS) are too low
  iter = 4000, # Default is usually 2000
  warmup = 2000 # Half of iter is a common choice
)


saveRDS(
  political_preferences,
  file = "models/consider_trump.rds"
)
