
## Fake one forked tree
tree_fork <- tree %>%
  mutate(
    stemNo = if_else(treeID  == "473646652001305C11", 2, 1),
    itemNo2 = if_else(treeID == "473646652001305C11", "10", itemNo),
    treeID2 = if_else(treeID == "473646652001305C11", "473646652001305C10", treeID)
  )

## IVI
tree_unique <- tree_fork %>%
  group_by(plotID, treeID2, itemNo2, ScName) %>%
  summarise(
    ba_tree = sum(ba_tree)
  ) %>%
  ungroup()

## AGB 
tree_agb <- tree_fork %>%
  mutate(agb_stem = 0.0509 * d2h^0.919 + 0.00893 * d2h^0.977 + 0.0140 * d2h^0.669) %>%
  group_by(plotID, treeID2, itemNo2, ScName, landuseTypeCode) %>%
  summarise(
    agb_tree = sum(agb_stem)
  ) %>%
  ungroup()
