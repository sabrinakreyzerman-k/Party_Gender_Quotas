#### Preamble ####
# Purpose: Create table for when Liberal MPs elected were female
# Author: Sabrina Kreyzerman
# Date: 11 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
## Load packages ##
library(tidyverse)
library(knitr)
library(janitor)
library(kableExtra)
library(here)

## Read in datasets ##
cleaned_politicians_data <- read_csv(here("Data/Clean/cleaned_politicians_data.csv"))
cleaned_party_data <- read_csv(here("Data/Clean/cleaned_party_data.csv"))
cleaned_mp_data <- read_csv(here("Data/Clean/cleaned_mp_data.csv"))
combined_politician_dataset <- read_csv(here("Data/Clean/combined_politician_dataset.csv"))

#### Create table ####
## Female Liberal MPs ##

#| label: tbl-female-liberal-mps
#| tbl-cap: "Number of Liberal Party MPs by gender elected directly following new Labor Party gender quotas"

combined_politician_dataset |> 
  filter(year_elected == '1993' | year_elected == "1996" |  year_elected == "2004" | year_elected == "2010" | year_elected == "2013" | year_elected == "2016") |>
  filter(partyName == 'Liberal Party of Australia') |>
  group_by(year_elected, gender) |>
  count() |>
  ungroup() |>
  pivot_wider(names_from = gender, values_from = n) |>
  mutate(percentage = round((female / (female + male)) * 100, 2)) |>
  kable(
    col.names = c("Election Year", "Number of Female MPs", "Number of Male MPs", "Percentage of female MPs"),
    booktabs = TRUE)