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
