#### Preamble ####
# Purpose: Simulates the data set for unemployment and personal income
# Author: Heyucheng Zhang, Jiwon Choi
# Date: 12 February 2024 
# Contact: heyucheng.zhang@mail.utoronto.ca, jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(ggplot2)
library(dplyr)
library(tibble)

#### Simulate data 1) ####
# Simulation for the change of unemployment rate between 1976 and 1989 for four major states
set.seed(123) # Setting seed for reproducibility
base_rate <- c(3.5, 4.5, 5.5, 3) # Lower base rates for states before recession
simulated_data1 <-
  tibble(
    # Create a sequence of years for each state
    year = rep(1976:1989, each = 4),
    # Replicate each state name for the length of the years
    state = rep(c("New York", "Florida", "Texas", "California"), times = length(1976:1989)),
    # Simulate unemployment rate data with lower rates before the recession
    rate = rep(base_rate, times = length(1976:1989)) + rnorm(length(1976:1989)*4, 0, 1)
  )

# Introduce a recession effect for 1980 to 1982, with a peak at 1982
simulated_data1 <- simulated_data1 %>%
  mutate(rate = rate + ifelse(year >= 1980 & year <= 1982, 2 + (year - 1980), 0) - # Increment rate during recession
           ifelse(year > 1982, (1982 - year) / 2, 0)) # Decrease after the recession ends

# Define custom colors for each state
state_colors <- c("New York" = "blue", "Florida" = "green", "Texas" = "yellow", "California" = "red")

# Create a line plot with custom styles
plot1 <- ggplot(simulated_data1, aes(x = year, y = rate, color = state)) +
  geom_line(size = 1) +
  scale_color_manual(values = state_colors) + # Set custom colors for lines
  geom_vline(xintercept = 1980, linetype="dashed", color = "red", size = 1) +
  geom_vline(xintercept = 1982, linetype="dashed", color = "red", size = 1) +
  annotate("text", x = 1980, y = max(simulated_data1$rate), label = "Recession Start", vjust = 2) +
  annotate("text", x = 1982, y = max(simulated_data1$rate), label = "Recession End", vjust = -0.5) +
  labs(title = "Average Unemployment Rate by Four Most Populated States and Year",
       x = "Year", y = "Average Unemployment Rate") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the plot title
        axis.text.x = element_text(angle = 45, hjust = 1), # Rotate x-axis labels (optional)
        legend.position = "bottom") # Move legend to the bottom

# Display the plot
print(plot1)


### Simulation 2 ###
# Simulation for the difference of unemployment for four major states before, during, and after recession
# Setting seed for reproducibility
set.seed(123)

# Use tibble to create the data frame for simulated changes in unemployment
# We're assuming an increase in unemployment rate during the recession
simulated_data2 <- tibble(
  state = rep(c("Florida", "New York", "Texas", "California"), times = 3),
  year = factor(rep(c("1986", "Recession", "1989"), each = 4), levels = c("1986", "Recession", "1989")),
  change = c(rnorm(4, 1, 0.5), rnorm(4, 5, 0.5), rnorm(4, 1, 0.5)) # Increase during Recession
)

# Define custom colors for the years
year_colors <- c("1986" = "green", "Recession" = "red", "1989" = "blue")

# Create a bar plot with custom styles
plot2 <- ggplot(simulated_data2, aes(x = state, y = change, fill = year)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +
  scale_fill_manual(values = year_colors) +  # Set custom colors for bars
  labs(title = "Change of Unemployment for Four Major States",
       x = "State", y = "Change in Unemployment Rate") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),  # Center the plot title
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels (optional)
    legend.position = "bottom"  # Move legend to the bottom
  )

# Display the plot
print(plot2)


### simulation 3 ###
# Simulation of personal income per capita over time from 1910 to 2013
set.seed(123)  # Set a specific seed value for reproducibility

simulated_data3 <-
  tibble(
    # Use the range of years from 1910 to 2013
    "Year" = 1910:2013,
    # Simulate the income per capita for each year
    "Income Per Capita" = cumsum(rnorm(104, 100, 50)) + 2000  # Simulating a gradual increase
  )

# Create a line plot with custom styles
plot3 <- ggplot(simulated_data3, aes(x = Year, y = `Income Per Capita`)) +
  geom_line(color = "forestgreen", size = 1) +  # Set line color and size
  labs(x = "Year", y = "Income Per Capita", 
       title = "Personal Income Per Capita by Year") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),  # Center the plot title
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotate x-axis labels (optional)
  )

# Display the plot
print(plot3)


#### Simulate data for business pattern 1 ####
set.seed(123) # Setting seed for reproducibility
simulated_data_business_pattern <-
  tibble(
    # Create a sequence of years from 1960 to 2000
    Year = 1960:2000,
    # Simulate total employment data with a gradual increase
    TotalEmployment = cumsum(runif(41, min = 5, max = 10)),
    # Simulate wage and salary employment data with a gradual increase
    WageSalaryEmployment = cumsum(runif(41, min = 3, max = 8)),
    # Simulate proprietors' employment data with a gradual increase
    ProprietorsEmployment = cumsum(runif(41, min = 2, max = 6))
  ) %>%
  # Reshape data for plotting
  gather(key = "EmploymentType", value = "Count", -Year)

# Define custom colors for employment types
employment_colors <- c("TotalEmployment" = "blue", 
                       "WageSalaryEmployment" = "red", 
                       "ProprietorsEmployment" = "orange")

# Create a line plot with custom styles
plot4 <- ggplot(simulated_data_business_pattern, aes(x = Year, y = Count, color = EmploymentType)) +
  geom_line(size = 1) +
  scale_color_manual(values = employment_colors) + # Set custom colors for lines
  labs(title = "Business Pattern 1",
       x = "Year", y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the plot title
        axis.text.x = element_text(angle = 45, hjust = 1), # Rotate x-axis labels (optional)
        legend.position = "bottom") # Move legend to the bottom

# Display the plot
print(plot4)


#### Simulate data for business pattern 2 ####
set.seed(123) # Setting seed for reproducibility

# Define the sectors
sectors <- c("Service", "Finance, Insurance, Real Estate", 
             "Agricultural Services, Forestry, and Fishing", 
             "Mining", "Construction", "Manufacturing", 
             "Transportation and Public Utilities", 
             "Wholesale Trade", "Retail Trade")

# Create a sequence of years from 1960 to 2000
years <- 1960:2000

# Generate random data for each sector
simulated_counts <- lapply(sectors, function(sector) {
  cumsum(runif(length(years), min = 50000, max = 200000)) # Random growth pattern
})

# Combine all data into a data frame
simulated_data_business_pattern2 <- tibble(
  Year = rep(years, times = length(sectors)),
  Sector = rep(sectors, each = length(years)),
  Count = unlist(simulated_counts)
)

# Define custom colors for each sector
sector_colors <- setNames(rainbow(length(sectors)), sectors)

# Create a line plot with custom styles
plot5 <- ggplot(simulated_data_business_pattern2, aes(x = Year, y = Count, color = Sector)) +
  geom_line(size = 1) +
  scale_color_manual(values = sector_colors) + # Set custom colors for lines
  labs(title = "Business Pattern 2",
       x = "Year", y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the plot title
        axis.text.x = element_text(angle = 45, hjust = 1), # Rotate x-axis labels (optional)
        legend.position = "bottom") # Move legend to the bottom

# Display the plot
print(plot5)

