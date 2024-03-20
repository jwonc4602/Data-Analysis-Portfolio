#### Preamble ####
# Purpose: Simulates the survey data set
# Author: Jeongwoo Kim, Jiwon Choi
# Date: 9 March 2024
# Contact: jwoo.kim@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

# Load necessary libraries
library(ggplot2)
library(tidyverse)

# Set the seed for reproducibility
set.seed(123)

# Define the number of samples you want to simulate for vote intention
n_vote_intention <- 6566

# Define the proportions from your vote intention data
proportions_vote_intention <- c(Yes = 34.39, No = 55.15, Other = 10.46)

# Adjust the proportions to be out of 1 for vote intention
proportions_vote_intention <- proportions_vote_intention / sum(proportions_vote_intention)

# Define the responses based on your vote intention categories
vote_intentions <- c("Yes", "No", "Other")

# Simulate the vote intentions based on the given proportions
simulated_vote_intentions <- sample(vote_intentions, size = n_vote_intention, replace = TRUE, prob = proportions_vote_intention)

# Calculate the frequency table of the simulated vote intentions
frequency_table_vote_intention <- table(simulated_vote_intentions)

# Create a tibble of frequencies and proportions for vote intention
result_table_vote_intention <- tibble(
  VoteIntention = names(frequency_table_vote_intention),
  Frequency = as.numeric(frequency_table_vote_intention),
  Proportion = as.numeric(frequency_table_vote_intention) / sum(frequency_table_vote_intention)
)

# Print the result table for vote intention
print(result_table_vote_intention)

# Bar plot for vote intention
ggplot(data = result_table_vote_intention, aes(x = VoteIntention, y = Frequency, fill = VoteIntention)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Bar Plot of Vote Intention to Trump", x = "Vote Intention", y = "Frequency")

# Pie chart for vote intention
pie(result_table_vote_intention$Frequency, labels = paste(result_table_vote_intention$VoteIntention, ": ", round(result_table_vote_intention$Proportion*100, 2), "%", sep=""),
    main = "Pie Chart of Vote Intention to Trump")


### Simulation 2) Data for the primary party ###
# Set the seed for reproducibility
set.seed(123)

# Define the number of samples you want to simulate
n_primary_party <- 6068

# Define the proportions from your data
proportions_primary_party <- c(Democratic = 39.37, Republican = 27.29, Other = 32.35)

# Adjust the proportions to be out of 1
proportions_primary_party <- proportions_primary_party / sum(proportions_primary_party)

# Define the party preferences based on your categories
party_preferences <- c("Democratic", "Republican", "Other")

# Simulate the party preferences based on the given proportions
simulated_primary_party <- sample(party_preferences, size = n_primary_party, replace = TRUE, prob = proportions_primary_party)

# Calculate the frequency table of the simulated party preferences
frequency_table_primary_party <- table(simulated_primary_party)

# Create a tibble of frequencies and proportions
result_table_primary_party <- tibble(
  PartyPreference = names(frequency_table_primary_party),
  Frequency = as.numeric(frequency_table_primary_party),
  Proportion = as.numeric(frequency_table_primary_party) / sum(frequency_table_primary_party)
)

# Print the result table
print(result_table_primary_party)

# Bar plot for primary party preference
ggplot(data = result_table_primary_party, aes(x = PartyPreference, y = Frequency, fill = PartyPreference)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Bar Plot of Primary Party Preference", x = "Party Preference", y = "Frequency")

# Pie chart for primary party preference
pie(result_table_primary_party$Frequency, labels = paste(result_table_primary_party$PartyPreference, ": ", round(result_table_primary_party$Proportion*100, 2), "%", sep=""),
    main = "Pie Chart of Primary Party Preference")

