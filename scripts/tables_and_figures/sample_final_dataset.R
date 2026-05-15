#### Preamble ####
# Purpose: Create sample table of final dataset
# Author: Sabrina Kreyzerman
# Date: 11 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
## Load packages ##
library(tidyverse)
library(AustralianPoliticians)
library(kableExtra)
library(here)

## Read in dataset ##
final_politician_data <- read_csv(here("data/clean/final_politician_data.csv"))

#### Create table ####
## Sample of final dataset ##

#| label: tbl-sample-dataset
#| tbl-cap: "Sample of Cleaned Australian Politicians Data"

final_politician_data |>
  filter(uniqueID == "Adams1951" | uniqueID == "Fitzgibbon1962" | uniqueID == "Brodtmann1963" | uniqueID == "Porter1970" | uniqueID == "Bird1962") |>
  select(uniqueID, name, gender, partyName, year_elected) |>
  kable(
    col.names = c("uniqueID", "Candidate Name", "Candidate Gender", "Candidate Party", "Year Elected"),
    booktabs = TRUE)