#### Preamble ####
# Purpose: Downloads real data from Spotify API for a selected artist, including 
#          track names, popularity, albums, and release dates.
# Author: Jiwon Choi
# Date: 10 October 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - `spotipy` must be installed (pip install spotipy)
#   - `pandas` must be installed (pip install pandas)


#### Workspace setup ####
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd

# Spotify credentials
client_id = '63532710d3a146fe96e2171e607636b6'
client_secret = '5c63c6b3a3684cb0bd56b48bca38cfa4'

# Authenticate with Spotify API
auth_manager = SpotifyClientCredentials(client_id=client_id, client_secret=client_secret)
sp = spotipy.Spotify(auth_manager=auth_manager)

# Download data for a particular artist (e.g., Taylor Swift)
artist_name = "Taylor Swift"
results = sp.search(q='artist:' + artist_name, type='artist')
artist = results['artists']['items'][0]
artist_id = artist['id']

# Get all albums
albums = sp.artist_albums(artist_id, album_type='album')

# Extract album ids
album_ids = [album['id'] for album in albums['items']]

# Extract all tracks from each album
track_data = []
for album_id in album_ids:
    album_tracks = sp.album_tracks(album_id)
    for track in album_tracks['items']:
        # Get track details including album and popularity
        track_info = sp.track(track['id'])
        track_data.append({
            'name': track_info['name'],
            'popularity': track_info['popularity'],
            'album': track_info['album']['name'],
            'release_date': track_info['album']['release_date'],
            'duration_ms': track_info['duration_ms']
        })

#### Save data ####
df_tracks = pd.DataFrame(track_data)
df_tracks.to_csv('data/01-raw_data/downloaded_tracks.csv', index=False)

         
