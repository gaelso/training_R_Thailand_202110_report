
library(tidyverse)

tt <- tibble(
  Letter = c("A", "A", "A", "B", "B", "B"),
  Number = 1:6
)

tt

tt %>%
  group_by(Letter) %>%
  summarise(
    count_number = n(),
    avg_number   = mean(Number),
    sd_number    = sd(Number)
  )
