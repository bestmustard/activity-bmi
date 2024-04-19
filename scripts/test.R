#### Preamble ####
# Purpose: Tests cleaned data
# Author: Victor Ma
# Date: 19 April 2024
# Contact: victo.ma@mail.utoronto.ca
# In this script I use code from OpenAI's ChatGPT4. Chatlogs can be found in the usage.txt file.




library(tidyverse)
# Check if files exist
if (!file.exists("inputs/data/analysis_data/analysis_data.csv")) {
  stop("CSV file does not exist.")
}

if (!file.exists("inputs/data/analysis_data/analysis_data.parquet")) {
  stop("Parquet file does not exist.")
}

# Load data
csv_data <- read.csv("inputs/data/analysis_data/analysis_data.csv")
parquet_data <- arrow::read_parquet("inputs/data/analysis_data/analysis_data.parquet")

# Check columns
required_columns <- c("obese", "activity", "income")
if (!all(required_columns %in% names(csv_data))) {
  stop("One or more required columns are missing in the CSV data.")
}

if (!all(required_columns %in% names(parquet_data))) {
  stop("One or more required columns are missing in the Parquet data.")
}

# Check for duplicates
if (any(duplicated(csv_data))) {
  stop("There are duplicate rows in the CSV data.")
}

if (any(duplicated(parquet_data))) {
  stop("There are duplicate rows in the Parquet data.")
}

# Validate data range for a hypothetical numeric column (if exists)
# assuming 'BMI' is a numeric column for demonstration
if (any(csv_data$BMI < 10 | csv_data$BMI > 50, na.rm = TRUE)) {
  stop("BMI values out of expected range [10, 50] in CSV data.")
}

# Check factor levels
expected_activity_levels <- c("No Activity", "Strength", "Cardio", "Cardio + Strength", "Double Cardio")
if (!all(levels(csv_data$activity) == expected_activity_levels)) {
  stop("Activity levels in CSV data do not match expected levels.")
}

# Check for missing values
if (any(is.na(csv_data))) {
  stop("There are missing values in the CSV data.")
}

# Ensure CSV and Parquet data are identical
if (!identical(csv_data, as.data.frame(parquet_data))) {
  stop("CSV and Parquet data files do not contain identical data.")
}

# Print a success message if all tests pass
cat("All tests passed successfully.\n")
