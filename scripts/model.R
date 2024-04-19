#### Preamble ####
# Purpose: Creates a logistic regression model
# Author: Victor Ma
# Date: 19 Apr 2024
# Contact: victo.ma@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
activity_data <- read_csv("inputs/data/analysis_data/analysis_data.csv")
activity_data$obese <- as_factor(activity_data$obese)
### Model data ####
set.seed(853)

# Reducing the dataset for manageable computation
activity_data_reduced <- activity_data |> 
  slice_sample(n = 3000)


# Specifying the logistic regression model
obesity_likelihood <- stan_glm(
  obese ~ activity + income,
  data = activity_data_reduced,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853
)

# Saving and loading the model for future analysis
saveRDS(obesity_likelihood, file = "models/obesity_likelihood.rds")