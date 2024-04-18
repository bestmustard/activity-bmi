#### Preamble ####
# Purpose: Cleans the raw 2020 CCES data recorded by Schaffner, Brian et.al 
# Author: Victor Ma
# Date: 15 Mar 2024
# Contact: victo.ma@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)

#### Clean data ####
raw_data <-
  read_csv("inputs/data/raw_data/Nutrition__Physical_Activity__and_Obesity_-_Behavioral_Risk_Factor_Surveillance_System.csv")

cleaned_data <- 
  raw_data |> 
  select ("Topic", "Question", "BMI") |>
  filter(Topic == "Physical Activity - Behavior") |>
  mutate(
    overweight = if_else(BMI >= 30, "Overweight", "Not Overweight"),
    overweight = as_factor(overweight),
    activity = case_when(
      Question == "Percent of adults who engage in no leisure-time physical activity" ~ "No Activity",
      Question == "Percent of adults who engage in muscle-strengthening activities on 2 or more days a week" ~ "Strength",
      Question == "Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)" ~ "Cardio",
      Question == "Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic physical activity and engage in muscle-strengthening activities on 2 or more days a week" ~ "Cardio + Strength",
      Question == "Percent of adults who achieve at least 300 minutes a week of moderate-intensity aerobic physical activity or 150 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)" ~ "Heavy Cardio"
    ), 
    activity = factor(
      activity,
      levels = c("No Activity", "Strength", "Cardio", "Cardio + Strength", "Heavy Cardio")
    )
  ) |>
  select(overweight, activity) |>
  filter(overweight != "NA")

#### Save the data ####
write_csv(cleaned_data, "inputs/data/analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "inputs/data/analysis_data/analysis_data.parquet")