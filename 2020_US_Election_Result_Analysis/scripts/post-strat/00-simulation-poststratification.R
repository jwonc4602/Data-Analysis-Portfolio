#### Preamble ####
# Purpose: Simulates the post-strat data set
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tibble)

### Simulation 1) Simulate data for age group distribution ###
set.seed(123) # Setting seed for reproducibility
age_groups <- c('18-29', '30-49', '50-69', '70+')
base_proportion <- c(50, 75, 25, 30) # These are the base proportions for the age groups

simulated_data1 <-
  tibble(
    # Create age group data
    age_group = rep(age_groups, times = 1),
    # Base proportion data
    proportion = base_proportion + rnorm(length(age_groups), 0, 5)
  )

# Create a bar plot with custom styles using ggplot
plot1 <- ggplot(simulated_data1, aes(x = age_group, y = proportion)) +
  geom_bar(stat = "identity", position = position_dodge(), fill = "blue") + # Set bar color to blue
  labs(title = "Distribution of Sample by Age Group",
       x = "Age Group", y = "Proportion") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the plot title
        axis.text.x = element_text(angle = 45, hjust = 1))

# Display the plot
print(plot1)

### Simulation 2) Simulate data for gender distribution ###
set.seed(123) # Setting seed for reproducibility

# Define gender proportions with some added random variation
gender_names <- c('male', 'female')
base_proportions <- c(45, 55) # Base proportions

simulated_data2 <- 
  tibble(
    gender = factor(gender_names, levels = gender_names),
    proportion = base_proportions + runif(length(gender_names), min = -5, max = 5) # Add random variation
  )

# Create a bar plot with all bars colored blue
plot2 <- ggplot(simulated_data2, aes(x = gender, y = proportion, fill = gender)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_manual(values = rep("blue", length(gender_names))) + # Set all bars to blue
  labs(title = "Distribution of Sample by Gender",
       x = "Gender", y = "Proportion") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the plot title
        legend.position = "none", # Remove the legend
        axis.text.x = element_text(angle = 45, hjust = 1)) # Optionally rotate x-axis labels

# Display the plot
print(plot2)


### Simulation 3) Simulate data for education distribution ###
set.seed(123) # Setting seed for reproducibility

# Assigning specific values for each education level
education_levels <- c('High School or less', 'Some college', 'College degree', 'Postgrad')
base_proportions <- c(25, 60, 50, 10) # Base proportions for simplicity

simulated_data3 <-
  tibble(
    education = factor(education_levels, levels = education_levels),
    proportion = base_proportions + runif(length(education_levels), min = -5, max = 5)
  )

# Create a bar plot with all bars colored blue
plot3 <- ggplot(simulated_data3, aes(x = education, y = proportion, fill = education)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_manual(values = rep("blue", length(education_levels))) + # Set all bars to blue
  labs(title = "Distribution of Sample by Education",
       x = "Education Level", y = "Proportion") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the plot title
        legend.position = "none", # Remove the legend
        axis.text.x = element_text(angle = 45, hjust = 1)) # Rotate x-axis labels for clarity

# Display the plot
print(plot3)

