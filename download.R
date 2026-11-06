library(tidyverse)
library(tidycensus)

# Table B09021 provides living arrangements of adults 18 and over by age
sarasota <- get_acs(
  geography = "tract",
  table = "B09021",
  state = "FL",
  county = "Sarasota",
  year = 2022
)

# Save downloaded data to an RDS file for analysis
write_rds(sarasota, "sarasota.rds")

# Download tract boundaries for mapping
tracts <- tigris::tracts(state = "FL", county = "Sarasota", cb = TRUE, year = 2022)
write_rds(tracts, "tracts.rds")

# Volusia County Census data and tract boundaries
volusia <- get_acs(
  geography = "tract",
  table = "B09021",
  state = "FL",
  county = "Volusia",
  year = 2022
)
write_rds(volusia, "volusia.rds")

volusia_tracts <- tigris::tracts(state = "FL", county = "Volusia", cb = TRUE, year = 2022)
write_rds(volusia_tracts, "volusia_tracts.rds")

# Central Florida region data and boundaries
cf_counties_list <- c("Orange", "Seminole", "Osceola", "Lake", "Brevard", "Volusia", "Polk")
cf_data <- get_acs(
  geography = "tract",
  table = "B09021",
  state = "FL",
  county = cf_counties_list,
  year = 2022
)
write_rds(cf_data, "central_florida.rds")

cf_tracts <- tigris::tracts(state = "FL", county = cf_counties_list, cb = TRUE, year = 2022)
write_rds(cf_tracts, "central_florida_tracts.rds")

cf_county_borders <- tigris::counties(state = "FL", cb = TRUE, year = 2022) |>
  filter(NAME %in% cf_counties_list)
write_rds(cf_county_borders, "central_florida_counties.rds")

# Nationwide state-level Census data and boundaries
states_data <- get_acs(
  geography = "state",
  table = "B09021",
  year = 2022
)
write_rds(states_data, "states_data.rds")

states_geo <- tigris::states(cb = TRUE, year = 2022) |>
  filter(!STATEFP %in% c("60", "66", "69", "72", "78")) |>
  sf::st_transform(4326)
write_rds(states_geo, "states_geo.rds")
