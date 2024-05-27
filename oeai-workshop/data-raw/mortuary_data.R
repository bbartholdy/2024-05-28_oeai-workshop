xlsx_url <- "https://osf.io/download/zem9p/"

download.file(xlsx_url, destfile = "data-raw/mortuary-data.xlsx", mode = "wb")

library(tidyverse)
library(readxl)

raw_data <- read_xlsx("data-raw/mortuary-data.xlsx")

str(raw_data)
