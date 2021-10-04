

## Aggregate tree to plot AGB ###############################################

plot_agb <- tree3 %>%
  mutate(scale_factor = 10) %>% ## note: plot area = 0.1 ha
  group_by(plotID) %>%
  summarise(
    agb    = sum(agb_thai) * scale_factor / 1000,
    ba     = sum(ba_tree) * scale_factor,
    n_tree = sum(scale_factor)
    ) %>%
  distinct() %>%
  ungroup() %>%
  left_join(plot, by = "plotID")

length(unique(tree3$plotID))

## More visualisations ######################################################

## Practice
## --- 1. point with basal area and AGB
## --- 1.1. same plus change color with land use
## --- 1.2. same plus make facets with land use
## --- 2. boxplot of AGB and land use (filter data if boxes are too small)
## --- 3. Create 3 different types of graphs with beautiful colors
