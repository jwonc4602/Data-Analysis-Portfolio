#### Preamble ####
# Purpose: Simulates a dataset of music tracks, including features like 
#          popularity, danceability, tempo, and duration.
# Author: Jiwon Choi
# Date: 10 October 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - `pandas` must be installed (pip install pandas)
#   - `numpy` must be installed (pip install numpy)


#### Workspace setup ####
import pandas as pd
import numpy as np

# Simulating data for 100 synthetic tracks
np.random.seed(853)
data = {
    'track_name': [f'Track_{i}' for i in range(100)],
    'popularity': np.random.randint(1, 101, size=100),
    'danceability': np.random.uniform(0.0, 1.0, size=100),
    'energy': np.random.uniform(0.0, 1.0, size=100),
    'tempo': np.random.uniform(60, 180, size=100),
    'duration_ms': np.random.randint(180000, 300000, size=100),  # in milliseconds
}

df_simulated = pd.DataFrame(data)

#### Save data ####
df_simulated.to_csv("data/00-simulated_data/simulated_data.csv", index=False)