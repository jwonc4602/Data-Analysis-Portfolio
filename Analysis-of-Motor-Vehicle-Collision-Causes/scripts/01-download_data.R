#### Preamble ####
# Purpose: Downloads and saves the data from the OpenDataToronto portal
# Author: Jiwon Choi
# Date: 17 September 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Data sets: https://open.toronto.ca/dataset/motor-vehicle-collisions-involving-killed-or-seriously-injured-persons/


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
package_id <- "0b6d3a00-7de1-440b-b47c-7252fd13929f"

# Get the package
package <-show_package(package_id)
package

# Get all resources for this package
resources <- list_package_resources(package_id)

# Identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

#### Save data ####
write_csv(data, "data/raw_data/raw_data.csv") 

         
