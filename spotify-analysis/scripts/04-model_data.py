#### Preamble ####
# Purpose: Builds a linear regression model to predict track popularity based 
#          on audio features from Spotify data.
# Author: Jiwon Choi
# Date: 10 October 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.py, 03-clean_data.py
#   - `pandas` must be installed (pip install pandas)
#   - `scikit-learn` must be installed (pip install scikit-learn)


#### Workspace setup ####
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error

# Load the cleaned data
df_cleaned = pd.read_csv('data/02-analysis_Data/cleaned_tracks.csv')
print(df_cleaned.columns)

# Define features and target
X = df_cleaned[['danceability', 'energy', 'tempo', 'duration_ms']]
y = df_cleaned['popularity']

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a linear regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Predict on test data
y_pred = model.predict(X_test)

# Evaluate the model
mse = mean_squared_error(y_test, y_pred)
print(f"Mean Squared Error: {mse}")

# Save the model (optional)
import pickle
with open('popularity_model.pkl', 'wb') as file:
    pickle.dump(model, file)

