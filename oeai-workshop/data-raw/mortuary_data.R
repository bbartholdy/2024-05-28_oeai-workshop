xlsx_url <- "https://osf.io/download/zem9p/"

download.file(xlsx_url, destfile = "data-raw/mortuary-data.xlsx", mode = "wb")

library(tidyverse)
library(readxl)

raw_data <- read_xlsx("data-raw/mortuary-data.xlsx")

str(raw_data) # view structure of object

renamed_data <- raw_data |>
  rename(
    Height = Hight,
    IndoPacific_bead = `Indo-Pacific_bead`
  ) 

renamed_data$Length

renamed_data |>
  mutate(
    Glass_bead = if_else(
      condition = Glass_bead == "shatter",
      true = NA,
      false = Glass_bead
    )
  ) |>
  mutate(
    IndoPacific_bead = case_when(
      IndoPacific_bead == "cluster" ~ NA,
      IndoPacific_bead == "unsure number" ~ NA,
      .default = IndoPacific_bead
    )
  ) |>
  mutate(
    across(
      c(Length, Width),
      \(x) str_remove(x, "\\+")
    )
  )

# modifying strings
mutate(renamed_data, Length = str_remove(Length, "\\+"))
str_remove(renamed_data$Width, "\\+")

renamed_data$Glass_bead == "shatter"
renamed_data$IndoPacific_bead

