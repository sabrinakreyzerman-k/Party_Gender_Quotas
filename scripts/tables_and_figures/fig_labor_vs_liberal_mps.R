#### Preamble ####
# Purpose: Create Figure for Female Labor MPs vs. female Liberal MPs elected from 1983-2021
# Author: Sabrina Kreyzerman
# Date: 11 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
## Load packages ##
library(tidyverse)
library(knitr)
library(janitor)
library(here)
library(ggplot2)
library(dplyr)
library(AustralianPoliticians)

## Read in dataset ##
final_politician_data <- read_csv(here("data/clean/final_politician_data.csv"))

#### Create Figure ####
## Female Labor MPs vs. female Liberal MPs elected from 1983-2021 ##

final_politician_data |>
  filter(
    partyName %in% c("Liberal Party of Australia", "Australian Labor Party"),
    gender == "female",
    !is.na(year_elected),
    year_elected >= 1983,
    year_elected <= 2021) |>
  group_by(year_elected, partyName) |>
  summarise(n_females = n_distinct(uniqueID), .groups = "drop") |>
  
  ggplot(mapping = aes(x = year_elected, y = n_females,
                       colour = partyName,
                       group  = partyName)) +
  geom_line(linewidth = 0.5) +
  geom_point(size = 0) +
  scale_colour_manual(
    values = c("Australian Labor Party" = "#E53440", "Liberal Party of Australia" = "#1C4F9C"),
    labels = c("Australian Labor Party",
               "Liberal Party of Australia")
  ) +
  scale_x_continuous(
    breaks = seq(1983, 2021, by = 3),
    limits = c(1983, 2021)
  ) +
  labs(
    title  = "Female Candidates Elected to Australian\nParliament between 1983 and 2021",
    x      = "Election Year",
    y      = "Number of Female Candidates Elected",
    colour = "Party"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title       = element_text(hjust = 0.5, size = 12),
    legend.position  = "bottom",
    axis.text.x      = element_text(angle = 0, hjust = 0.5, size = 10),
    axis.title.x     = element_text(size = 10),
    axis.text.y      = element_text(angle = 0, hjust = 0.5, size = 10),
    axis.title.y     = element_text(size = 10),
    panel.grid.minor = element_blank()
  )