#### Preamble ####
# Purpose: Clean downloaded AustralianPoliticians data
# Author: Sabrina Kreyzerman
# Date: 7 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # download_raw_data.R

#### Workspace setup ####
## Load packages ##
library(tidyverse)

## Read in datasets ##
politician_data <- read_csv("data/raw/politician_data.csv")
party_data <- read_csv("data/raw/party_data.csv")
mp_data <- read_csv("data/raw/mp_data.csv")

#### Clean data ####
## Select relevant columns ##
clean_politician_data <- politician_data |>
  rename(name = displayName) |>
  select(uniqueID, name, gender, birthDate, member)

clean_party_data <- party_data |>
  select(uniqueID, partyAbbrev, partyName, partySimplifiedName)

clean_mp_data <- mp_data |>
  rename(year_elected = mpFrom) |>
  select(uniqueID, year_elected)

## Retain only the year from "mpFrom" column ##
clean_mp_data$year_elected <-year(clean_mp_data$year_elected)

#### Save dataset ####
write_csv(clean_politician_data, "data/clean/clean_politician_data.csv")
write_csv(clean_party_data, "data/clean/clean_party_data.csv")
write_csv(clean_mp_data, "data/clean/clean_mp_data.csv")

#### Match up datasets ####
clean_politician_data <- clean_politician_data |>
  left_join(clean_party_data, by = "uniqueID")

clean_politician_data <- clean_politician_data |>
  left_join(clean_mp_data, by = "uniqueID")

#### Save matched up dataset ####
write_csv(clean_politician_data, "data/clean/combined_politician_data.csv")

#### Read in matched up dataset ####
combined_politician_data <- read_csv("data/clean/combined_politician_data.csv")
