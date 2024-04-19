#### Preamble ####
# Purpose: Simulates probability of being obese by activity level
# Author: Victor Ma
# Date: 19 April 2024
# Contact: victo.ma@mail.utoronto.ca
# In this simulation I use code from Alexander, Rohan 


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(853)


num_obs <- 1000 

# Simulating data on obesity based on activity level and income
simulated_obesity_data <- tibble(
  income = sample(0:5, size = num_obs, replace = TRUE), # Simulate income categories
  activity = sample(0:4, size = num_obs, replace = TRUE), # Simulate activity levels
  obese_prob = ((income + activity) / 10) # Simplified probability model
) %>%
  mutate(
    obese = if_else(runif(n = num_obs) < obese_prob, "Yes", "No"),
    obese = as_factor(obese),
    income = case_when(
      income == 0 ~ "0-15",
      income == 1 ~ "15-25",
      income == 2 ~ "25-35",
      income == 3 ~ "35-50",
      income == 4 ~ "50-75",
      income == 5 ~ "75+"
    ),
    activity = case_when(
      activity == 0 ~ "No Activity",
      activity == 1 ~ "Strength",
      activity == 2 ~ "Cardio",
      activity == 3 ~ "Cardio + Strength",
      activity == 4 ~ "Double Cardio"
    ),
    income = factor(
      income,
      levels = c("0-15", "15-25", "25-35", "35-50", "50-75", "75+")
    ),
    activity = factor(
      activity,
      levels = c("No Activity", "Strength", "Cardio", "Cardio + Strength", "Double Cardio")
    )
  ) %>%
  select(obese_prob, obese, activity, income)