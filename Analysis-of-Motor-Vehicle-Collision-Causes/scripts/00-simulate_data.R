#### Preamble ####
# Purpose: Simulates the Motor Vehicle Collision Causes data set
# Author: Jiwon Choi
# Date: 19 September 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(tibble)

#### Simulation 1) Human factors: AG-DRIV, Alcohol, Speeding ####
set.seed(123)  # Setting seed for reproducibility

# Simulate random data for human factors
human_factors <- tibble(
  "Factor" = c("AG-DRIV", "Alcohol", "Speeding", "Disability"),
  "Yes" = runif(4, 30, 80),  # Random 'Yes' values between 30 and 80
  "No" = 100 - Yes  # 'No' is complementary to 'Yes' so they sum to 100
)

# Plot: Human factors
human_factors_long <- human_factors %>%
  pivot_longer(cols = c("Yes", "No"), names_to = "Response", values_to = "Count")

plot1 <- ggplot(human_factors_long, aes(x = Factor, y = Count, fill = Response)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Human Factor", y = "Count", fill = "Response", title = "Human Factors (Yes/No)") +
  theme_minimal()

# Display the plot
print(plot1)

#### Simulation 2) Environmental factors: Traffic control, Visibility, Road surface ####
set.seed(123)  # Setting seed for reproducibility

# Simulate random data for traffic control type
traffic_control <- tibble(
  "Control Type" = c("No Control", "Traffic Signal", "Others"),
  "Count" = runif(3, 20, 60)  # Random counts between 20 and 60
)

# Plot: Traffic control type
plot2 <- ggplot(traffic_control, aes(x = `Control Type`, y = Count)) +
  geom_line(group = 1, color = "blue", size = 1) +
  geom_point(size = 3, color = "blue") +
  labs(x = "Traffic Control Type", y = "Count", title = "Traffic Control Types") +
  theme_minimal()

# Display traffic control plot
print(plot2)

# Simulate random data for visibility conditions
visibility <- tibble(
  "Condition" = c("Clear", "Disturbed"),
  "Count" = runif(2, 30, 80)  # Random counts between 30 and 80
)

# Plot: Visibility conditions
plot3 <- ggplot(visibility, aes(x = Condition, y = Count)) +
  geom_line(group = 1, color = "yellow", size = 1) +
  geom_point(size = 3, color = "yellow") +
  labs(x = "Visibility Condition", y = "Count", title = "Visibility Conditions") +
  theme_minimal()

# Display visibility plot
print(plot3)

# Simulate random data for road surface conditions
road_surface <- tibble(
  "Condition" = c("Others", "Dry", "Wet"),
  "Count" = runif(3, 30, 80)  # Random counts between 30 and 80
)

# Plot: Road surface conditions
plot4 <- ggplot(road_surface, aes(x = Condition, y = Count)) +
  geom_line(group = 1, color = "darkblue", size = 1) +
  geom_point(size = 3, color = "darkblue") +
  labs(x = "Road Surface Condition", y = "Count", title = "Road Surface Conditions") +
  theme_minimal()

# Display road surface condition plot
print(plot4)

