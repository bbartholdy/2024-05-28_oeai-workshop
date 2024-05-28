library(tidyverse)

mortuary_data <- read_csv("data/mortuary_clean.csv")

mortuary_data |>
  summarise(
    mean_golden = mean(Golden_bead, na.rm = T),
    median_golden = median(Golden_bead, na.rm = T),
    sd_golden = sd(Golden_bead, na.rm = T),
    .by = Phase
  )

str(mortuary_data)

mortuary_data |>
  summarise(
    across(
      contains("bead"),
      \(x) mean(x, na.rm = T)
    )
  )

mortuary_data |>
  ggplot(aes(x = Stone_artifact)) +
    geom_bar()


View(mortuary_data)

mortuary_long <- mortuary_data |>
  pivot_longer(
    Agate_bead:Kendi_mouth,
    names_to = "artefact",
    values_to = "count"
  )

mortuary_long |>
  group_by(Phase, artefact) |>
  summarise(
    mean = mean(count, na.rm = T),
    median = median(count, na.rm = T)
  ) |>
  arrange(desc(mean))

mortuary_long |>
  filter(artefact != "IndoPacific_bead") |>
  ggplot(aes(x = artefact, y = count, fill = Phase)) +
  geom_col()

mortuary_wide <- mortuary_long |>
  pivot_wider(
    names_from = artefact,
    values_from = count
  )

dim(mortuary_data) == dim(mortuary_wide)

write_csv(mortuary_long, "data/mortuary_long.csv")
