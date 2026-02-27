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
fishing_Type <- c("Industrial", "Artisanal")
vessel_type <- c("Trawl", "Longline", "Net")

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
    vessel_type = sample(vessel_type, n(), replace = TRUE),
    fishing_Type = sample(fishing_Type, n(), replace = TRUE)
  )

# Save dataset
write_csv(synthetic_data, "GitHub_Projects/fisheries-production-eda/data/fisheries_production.csv")

# Preview
head(synthetic_data)




# --------------------------------------------
# Basic Exploratory Analysis
# --------------------------------------------

# Summary statistics
summary(synthetic_data)

# Total production by year
production_by_year <- synthetic_data %>%
  group_by(Year) %>%
  summarise(Total_Production = sum(Production_Tons))

# Plot production trend
ggplot(production_by_year, aes(x = Year, y = Total_Production)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Total Fisheries Production by Year",
    x = "Year",
    y = "Total Production (Tons)"
  ) +
  theme_minimal()




# --------------------------------------------
# Total production by year
# --------------------------------------------

production_by_year <- synthetic_data %>%
  group_by(Year) %>%
  summarise(Total_Production = sum(Production_Tons))

production_plot <- ggplot(production_by_year, aes(x = Year, y = Total_Production)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Total Fisheries Production by Year",
    x = "Year",
    y = "Total Production (Tons)"
  ) +
  theme_minimal()


# Create output directory if it doesn't exist
if (!dir.exists("GitHub_Projects/fisheries-production-eda/output/figures")) {
  dir.create("GitHub_Projects/fisheries-production-eda/output/figures", recursive = TRUE)
}


# Save plot automatically
ggsave(
  filename = "GitHub_Projects/fisheries-production-eda/output/figures/production_by_year.png",
  plot = production_plot,
  width = 8,
  height = 5,
  dpi = 300
)