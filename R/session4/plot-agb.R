

## Aggregate tree to plot AGB ###############################################

plot_agb <- tree_agb %>%
  mutate(scale_factor = 10) %>% ## note: plot area = 0.1 ha
  group_by(plotID) %>%
  summarise(
    agb_c3    = sum(agb_thai_c3, na.rm = T) * scale_factor_c3 / 1000,
    ba     = sum(ba_tree_c3) * scale_factor_c3,
    n_tree = sum(scale_factor_c3)
    ) %>%
  distinct() %>%
  ungroup() %>%
  left_join(plot_c3, by = "plotID")

length(unique(tree_agb$plotID))

## More visualisations ######################################################

## Practice
## --- 1. point with basal area and AGB
## --- 1.1. same plus change color with land use
## --- 1.2. same plus make facets with land use
## --- 2. boxplot of AGB and land use (filter data if boxes are too small)
## --- 3. Create 3 different types of graphs with beautiful colors
