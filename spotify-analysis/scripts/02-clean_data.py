#### Preamble ####
# Purpose: Cleans the downloaded Spotify data by handling missing values and 
#          standardizing formats for analysis.
# Author: Jiwon Choi
# Date: 10 October 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.py
#   - `pandas` must be installed (pip install pandas)


#### Workspace setup ####
import pandas as pd

# Load the downloaded data
df_tracks = pd.read_csv('data/01-raw_data/downloaded_tracks.csv')

# Clean the data (handle missing values, standardize formats)
df_tracks['popularity'] = df_tracks['popularity'].fillna(df_tracks['popularity'].mean())
df_tracks['release_date'] = pd.to_datetime(df_tracks['release_date'], errors='coerce')

# Remove any tracks with missing release dates
df_cleaned = df_tracks.dropna(subset=['release_date'])

# Save the cleaned data
df_cleaned.to_csv('data/02-analysis_Data/cleaned_tracks.csv', index=False)
