#### Preamble ####
# Purpose: Download AustralianPoliticians data
# Author: Sabrina Kreyzerman
# Date: 7 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(AustralianPoliticians)

#### Download data ####
## Download politician data ##
politician_data <- get_auspol("all")

## Download party data ##
party_data <- get_auspol("allbyparty")

## Download MP data ##
mp_data <- get_auspol("mps")

#### Save datasets ####
write_csv(politician_data, "data/raw/politician_data.csv")
write_csv(party_data, "data/raw/party_data.csv")
write_csv(mp_data, "data/raw/mp_data.csv")