# --------------------------------------------
# Fisheries Production - Exploratory Data Analysis
# --------------------------------------------

# Load libraries
library(dplyr)
library(ggplot2)
library(readr)

# Set seed for reproducibility
set.seed(123)

# Create synthetic dataset

years <- 2015:2024
months <- 1:12
regions <- c("North Coast", "South Coast", "Offshore")
species <- c("Tuna", "Salmon", "Sardine", "Cod")
vessel_type <- c("Industrial", "Artisanal")
fishing_method <- c("Trawl", "Longline", "Net")

synthetic_data <- expand.grid(
  Year = years,
  Month = months,
  Region = regions,
  Species = species
)

synthetic_data <- synthetic_data %>%
  mutate(
    Production_Tons = round(rnorm(n(), mean = 500, sd = 120)),
    Avg_Price_per_Ton = round(rnorm(n(), mean = 2000, sd = 300), 2),
    Vessel_Type = sample(vessel_type, n(), replace = TRUE),
    Fishing_Method = sample(fishing_method, n(), replace = TRUE)
  )

# Save dataset
write_csv(synthetic_data, "../data/fisheries_production.csv")

# Preview
head(synthetic_data)