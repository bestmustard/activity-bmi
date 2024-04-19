# The correlation between activity levels, income, and obesity in the United States

## Overview

This repository contains a study on how an individual's amount of exercise conducted per week and their income level impacts their probability of being obese.


## File Structure

The repo is structured as:

-   `inputs/data/raw_data` contains the raw data as obtained from https://data.cdc.gov/Nutrition-Physical-Activity-and-Obesity/Nutrition-Physical-Activity-and-Obesity-Behavioral/hn4x-zwk7/about_data
-   `inputs/data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains the fitted model. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data, as well as the script to create the model. 


## Statement on LLM usage

Aspects of the code were written with the help of OpenAI's ChatGPT4. Part of the data section and the discussion were written with this GPT, and the entire chat history is available in inputs/llms/usage.txt.
