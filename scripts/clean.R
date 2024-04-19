#### Preamble ####
# Purpose: Cleans the raw 2020 CCES data recorded by Schaffner, Brian et.al 
# Author: Victor Ma
# Date: 19 Apr 2024
# Contact: victo.ma@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)

#### Clean data ####
raw_data <-
  read_csv("inputs/data/raw_data/Nutrition__Physical_Activity__and_Obesity_-_Behavioral_Risk_Factor_Surveillance_System.csv")

length(which(raw_data$Question == "Percent of adults who engage in no leisure-time physical activity"))


cleaned_data <- 
  raw_data |> 
  select ("Topic", "Question", "BMI", "Income") |>
  filter(Topic == "Physical Activity - Behavior") |>
  mutate(
    obese = if_else(BMI >= 30, "Yes", "No"),
    obese = as_factor(obese),
    activity = case_when(
      Question == "Percent of adults who engage in no leisure-time physical activity" ~ "No Activity",
      Question == "Percent of adults who engage in muscle-strengthening activities on 2 or more days a week" ~ "Strength",
      Question == "Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)" ~ "Cardio",
      Question == "Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic physical activity and engage in muscle-strengthening activities on 2 or more days a week" ~ "Cardio + Strength",
      Question == "Percent of adults who achieve at least 300 minutes a week of moderate-intensity aerobic physical activity or 150 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)" ~ "Double Cardio"
    ), 
    activity = factor(
      activity,
      levels = c("No Activity", "Strength", "Cardio", "Cardio + Strength", "Double Cardio")
    ),
    activity=as_factor()
    income = case_when(
      Income == "Less than $15,000" ~ "0-15", 
      Income == "$15,000 - $24,999" ~ "15-25", 
      Income == "$25,000 - $34,999" ~ "25-35", 
      Income == "$35,000 - $49,999" ~ "35-50", 
      Income == "$50,000 - $74,999" ~ "50-75", 
      Income =="$75,000 or greater" ~ "75+"
    ),
    income= factor(
      income,
      levels = c("0-15", "15-25", "25-35", "35-50", "50-75", "75+")
    )
  ) |>
  select(obese, activity, income) |>
  filter(income != "Data not reported") %>% drop_na()



#### Save the data ####
write_csv(cleaned_data, "inputs/data/analysis_data/analysis_data.csv")

write_parquet(cleaned_data, "inputs/data/analysis_data/analysis_data.parquet")