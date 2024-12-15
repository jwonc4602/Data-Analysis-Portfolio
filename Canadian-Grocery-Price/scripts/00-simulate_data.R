#### Preamble ####
# Purpose: Simulates a dataset of grocery prices across multiple vendors, 
# capturing timestamps, prices, and other details.
# Author: Jiwon Choi
# Date: 14 November 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Make sure you are in the correct project directory

#### Workspace setup ####
library(tidyverse)
set.seed(853)

#### Simulate data ####

# Vendor names
vendors <- c("Metro", "Voila", "Loblaws", "Walmart", "NoFrills", "T&T", "Galleria", "Save-On-Foods")

# Product names
products <- c("Sourdough Bread", "Becel Margarine", "Organic Apples", "Milk 2L", "Brown Rice 1kg", 
              "Eggs Dozen", "Pasta 500g", "Orange Juice 1L", "Chicken Breast 1kg", "Butter 500g")

# Unit types
units <- c("g", "kg", "L", "count")

# Simulation parameters
n_divisions <- 500  # Total number of data points

# Create a dataset by randomly assigning values to simulate grocery prices
simulated_data <- tibble(
  nowtime = sample(seq(as.POSIXct("2024-02-28 00:00:00"), as.POSIXct("2024-11-01 23:59:59"), by = "hour"), 
                   size = n_divisions, replace = TRUE),  # Random timestamps
  current_price = round(runif(n_divisions, min = 1, max = 20), 2),  # Random prices between $1 and $20
  old_price = ifelse(runif(n_divisions) < 0.2, current_price * runif(n_divisions, 1.1, 1.5), NA),  # 20% chance of sale price
  price_per_unit = current_price / runif(n_divisions, 0.1, 2),  # Calculated price per unit
  vendor = sample(vendors, size = n_divisions, replace = TRUE, 
                  prob = c(0.15, 0.15, 0.2, 0.2, 0.1, 0.05, 0.1, 0.05)),  # Probabilities based on market share
  product_name = sample(products, size = n_divisions, replace = TRUE),  # Random product names
  units = sample(units, size = n_divisions, replace = TRUE),  # Random units
  product_id = paste0("P", sample(1000:9999, n_divisions, replace = TRUE))  # Unique product IDs
)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_grocery_data.csv")

