
## Main script to calculate Importance Value Index
tree_unique <- tree %>%
  mutate(
    stemNo = if_else(treeID  == "473646652001305C11", 2, 1),
    itemNo2 = if_else(treeID == "473646652001305C11", "10", itemNo),
    treeID2 = if_else(treeID == "473646652001305C11", "473646652001305C10", treeID)
    )%>%
  group_by(plotID, treeID2, itemNo2, ScName) %>%
  summarise(
    ba_tree = sum(ba_tree)
  ) %>%
  ungroup()

ivi_data <- tree_unique

## Visualize data ------
ivi_data %>%
  ggplot(aes(x = dbh, y = h, color = ScName)) +
  geom_point() +
  theme_bw() +
  theme(legend.position = "none")

length(unique(ivi_data$ScName))

## Modify the data ------
plot_area  <- 0.1
total_area <- length(unique(ivi_data$plotID)) * plot_area ## Each plot is 0.1 ha

ivi_freq <- ivi_data %>% 
  select(ScName, plotID) %>%
  distinct() %>%
  group_by(ScName) %>%
  summarise(frequency = n() * plot_area / total_area)

ivi_dom <- ivi_data %>%
  group_by(ScName) %>%
  summarise(dominance = sum(ba_tree * scale_factor) / total_area)

ivi_dens <- ivi_data %>%
  group_by(ScName) %>%
  summarise(density = sum(scale_factor) / total_area)

species_ivi <- ivi_freq %>%
  left_join(ivi_dom, by = "ScName") %>%
  left_join(ivi_dens, by = "ScName") %>%
  mutate(
    relative_freq = frequency / sum(ivi_freq$frequency) * 100,
    relative_dom  = dominance / sum(ivi_dom$dominance) * 100,
    relative_dens = density / sum(ivi_dens$density) * 100,
    IVI           =  relative_freq + relative_dom + relative_dens
    ) %>%
  arrange(desc(IVI)) %>%
  filter(ScName != "Unknown") %>%
  slice_head(n = 20)
species_ivi


## Save the results ----
write_csv(species_ivi, "results/species_ivi20_allplots.R")


