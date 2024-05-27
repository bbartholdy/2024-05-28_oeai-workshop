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

length(mortuary_data$ID)
dim(mortuary_data)

mutate(
  known_context,
  dataset = "Kewulian Burials"
)

pit_area <- mutate(
  known_context,
  Area = Length * Width,
  .after = Height
)

mortuary_data |> # take mortuary_data, and then
  filter(Phase != "disturbed") |> # filter out "disturbed", and then
  mutate(Area = Length * Width, .after = Height) # create Area

select(mortuary_data, ID, Length, Width, Height) # select by name
select(mortuary_data, 1, 3, 4, 5) # select by position
select(mortuary_data, !c(Layer, Pit, Coffin)) # NOT select by name

select(mortuary_data, !Layer, !Pit, !Coffin) # Does NOT work as expected

dimension_data <- mortuary_data |> # take mortuary_data, and then
  filter(Phase != "disturbed") |> # filter out "disturbed", and then
  mutate(Area = Length * Width, .after = Height) |>
  select(ID, Length, Width, Height, Area, Phase)

data.frame(mortuary_data) # standard data frame
