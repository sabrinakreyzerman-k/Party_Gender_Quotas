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

## Read in dataset ##
combined_politician_dataset <- read_csv(here("Data/Clean/combined_politician_dataset.csv"))

#### Create Figure ####
## Female Labor MPs vs. female Liberal MPs elected from 1983-2021 ##
## Line plot ##

#| label: fig-female-mps-over-time
#| fig-cap: "Female Candidates Elected to Australian Parliament between 1983 and 2021"

combined_politician_dataset %>%
  filter(
    partySimplifiedName %in% c("Liberals", "Labor"),
    gender == "female",
    member == 1,
    !is.na(year_elected),
    year_elected >= 1983,
    year_elected <= 2021) |>
  group_by(year_elected, partySimplifiedName) |>
  summarise(n_females = n_distinct(uniqueID), .groups = "drop") |>
  
  ggplot(mapping = aes(x = year_elected, y = n_females,
                       colour = partySimplifiedName,
                       group  = partySimplifiedName)) +
  geom_line(linewidth = 0.5) +
  geom_point(size = 0) +
  scale_colour_manual(
    values = c("Labor" = "#E53440", "Liberals" = "#1C4F9C"),
    labels = c("Labor" = "Australian Labor Party",
               "Liberals" = "Liberal Party of Australia")
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