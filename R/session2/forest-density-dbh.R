
## Main script to calculate non-carbon forest indicators


## Visualize data ------
count_tree <- tree %>%
  mutate(dbh_class = trunc(dbh / 10) * 10) %>%
  group_by(dbh_class) %>%
  summarize(
    count = sum(scale_factor)
    )

ggplot(count_tree, aes(x = dbh_class, y = count)) +
  geom_col() +
  theme_bw() +
  theme(legend.position = "none")


## Modify the data ------
plot_density <- tree %>%
  mutate(dbh_class = trunc(dbh / 10) * 10) %>%
  group_by(plotID, landuseTypeCode, dbh_class) %>%
  summarize(density = sum(scale_factor))

ggplot(plot_density, aes(x = dbh_class, group = dbh_class, y = density)) +
  geom_boxplot() +
  theme_bw() +
  theme(legend.position = "none")

## Save the results ----
write_csv(plot_density, "results/plot_density.R")


## 







