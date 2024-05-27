library(tidyverse)
mortuary_data <- read_csv("data/mortuary_clean.csv")

copy <- mortuary_data

mortuary_data |>
  ggplot(aes(x = Length)) +
    geom_histogram(bins = 10)

mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_density(fill = "blue", alpha = 0.5)

mortuary_data |>
  remove_missing(vars = "Phase") |>
  ggplot(aes(x = Phase, y = Length)) +
    geom_boxplot(
      outlier.shape = NA
    ) +
    geom_jitter(
      width = 0.2,
      height = 0.2
    )

mortuary_data |>
  ggplot(aes(x = Phase)) +
  geom_bar()

mortuary_data$Gender

# Exercise

# Recode the Gender variable from numbers to strings. Call the new variable Sex
# 1 = Male
# 2 = Probable Male
# 3 = Female
# 4 = Probable Female
# NA = Unobservable

mortuary_data_sex <- mortuary_data |>
  mutate(
    Sex = case_when(
      Gender == 1 ~ "Male",
      Gender == 2 ~ "Probable Male",
      Gender == 3 ~ "Female",
      Gender == 4 ~ "Probable Female",
      is.na(Gender) ~ "Unobservable"
    )
  )

mortuary_data_sex |>
  ggplot(aes(x = Phase, fill = Sex)) +
  geom_bar()

percent_sex <- mortuary_data_sex |>
  count(Phase, Sex) |>
  group_by(Phase) |>
  mutate(percent = (n / sum(n)) * 100)

percent_sex |>
  ggplot(aes(x = Phase, y = percent, fill = Sex)) +
  geom_bar(stat = "identity")
  
percent_sex |>
  ggplot(aes(x = Phase, y = percent, fill = Sex)) +
  geom_col()

ggsave("figures/sex-distribution.png")
