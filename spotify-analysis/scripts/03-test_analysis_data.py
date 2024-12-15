#### Preamble ####
# Purpose: Performs basic exploratory data analysis on cleaned Spotify data, 
#          including visualizations and summary statistics.
# Author: Jiwon Choi
# Date: 10 October 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.py, 03-clean_data.py
#   - `pandas` must be installed (pip install pandas)
#   - `matplotlib` must be installed (pip install matplotlib)


#### Workspace setup ####
import pandas as pd
import matplotlib.pyplot as plt

# Load the cleaned data
df_cleaned = pd.read_csv('data/02-analysis_Data/cleaned_tracks.csv')

# Basic analysis
print(df_cleaned.describe())

# Plotting popularity vs. duration
plt.figure(figsize=(10, 6))
plt.scatter(df_cleaned['popularity'], df_cleaned['duration_ms'], alpha=0.5)
plt.title('Popularity vs Duration (ms)')
plt.xlabel('Popularity')
plt.ylabel('Duration (ms)')
plt.show()
