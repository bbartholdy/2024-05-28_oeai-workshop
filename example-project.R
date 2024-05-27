library(tidyverse)

mortuary_data <- read_csv("https://edu.nl/hwgat")

ggplot(
  data = mortuary_data,
  mapping = aes(x = Length, y = Width)
  ) + 
  geom_point(col = "#ffffff")

ggplot(
  data = mortuary_data,
  mapping = aes(x = Length, y = Width)
) + 
  geom_point(aes(colour = Phase, shape = Phase)) +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_viridis_d() +
  theme_minimal()

filter(
  mortuary_data,
  Phase == "pre" |
    Phase == "chi" |
    Phase == "post" |
    Phase == "euro"
  )

known_context <- filter(
  mortuary_data,
  Phase != "disturbed"
)

# under the hood of filter()
mortuary_data$Phase != "disturbed"

arrange(known_context, desc(Length)) # descending order of Length

data.frame(mortuary_data) # standard data frame
