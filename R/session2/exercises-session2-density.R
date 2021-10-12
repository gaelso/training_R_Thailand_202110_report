

## Tree density per diameter class
## -- 1. Calculate the average density per class for all forests and their confidence interval

tree_density <- tree %>%
  mutate(dbh_class = trunc(dbh / 10) * 10)

table(tree_density$dbh_class)

plot_density <- tree_density %>%
  group_by(plotID, landuseTypeCode, dbh_class) %>%
  summarise(density = sum(scale_factor))

forest_density <- plot_density %>%
  group_by(dbh_class) %>%
  summarise(
    nb_plot = n(),
    density_avg = mean(density),
    density_sd = sd(density)
    )

## -- 2. Make a barplot with this result
ggplot(forest_density, aes(x = dbh_class, y = density_avg)) +
  geom_col(aes(fill = dbh_class), col = "black") +
  scale_fill_viridis_c(direction = -1) +
  theme_bw() +
  theme(legend.position = "none")

## -- 3. Remake 1. and 2. with only plots in Tropical Evergreen Forest
## -- 4. (optional) Combine barplots from 2. and 3. into one graph with ggarrange()


