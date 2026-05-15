#### Preamble ####
# Purpose: Create final dataset for use
# Author: Sabrina Kreyzerman
# Date: 11 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
## Load packages ##
library(tidyverse)
library(here)
library(dplyr)

## Read in datasets ##
combined_politician_data <- read_csv(here("data/clean/combined_politician_data.csv"))

final_politician_data <- combined_politician_data |>
  select(uniqueID, name, gender, partyName, year_elected)

#### Save final dataset ####
write_csv(final_politician_data, "data/clean/final_politician_data.csv")

#### Read in final dataset ####
final_politician_data <- read_csv("data/clean/final_politician_data.csv")

ncol(final_politician_data)
names(final_politician_data)