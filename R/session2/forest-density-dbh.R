
## Main script to calculate non-carbon forest indicators


## Visualize data ------
count_tree <- tree %>%
  filter(dbh > 5) %>%
  mutate(dbh_class = round((dbh - 2.5) / 5, 0) * 5) %>%
  group_by(dbh_class) %>%
  summarize(count = sum(scale_factor))

ggplot(count_tree, aes(x = dbh_class, y = count)) +
  geom_col() +
  theme_bw() +
  theme(legend.position = "none")


## Modify the data ------
plot_density <- tree %>%
  mutate(dbh_class = trunc(dbh / 10) * 10) %>%
  group_by(plotID, landuseTypeCode, dbh_class) %>%
  summarize(density = sum(scale_factor)) %>%
  mutate(dbh_class_f = fct_reorder(paste0("c", dbh_class)))

ggplot(plot_density, aes(x = dbh_class_f, y = density)) +
  geom_boxplot() +
  theme_bw() +
  theme(legend.position = "none")

## Save the results ----
write_csv(plot_density, "results/plot_density.R")


