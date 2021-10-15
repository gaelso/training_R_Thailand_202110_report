
## Tree data cleaning #######################################################

## --- Visual checks --------------------------------------------------------
## Check outliers in DBH and H
ggplot(tree) +
  geom_point(aes(x = dbh, y = h))

ggplot(tree_c4) +
  geom_point(aes(x = dbh, y = h))


## --- Combine --------------------------------------------------------------

plot_codes <- plot_c4 %>% pull(plotID)

## Filter Cycle 3 data
plot_c3 <- plot %>% filter(plotID %in% plot_codes)
tree_c3 <- tree %>% filter(plotID %in% plot_codes)

## Checks
ggplot(tree_c3) +
  geom_point(aes(x = dbh, y = h))

ggplot(data = tree_c3, aes(x = dbh, y = h)) +
  geom_point() +
  geom_point(data = tree_c4, col = "darkred", shape = 3) +
  theme_bw()

ggplot(data = tree_c3, aes(x = dbh, y = h, label = itemNo)) +
  geom_text(size = 3) +
  geom_text(data = tree_c4, col = "darkred", size = 3) +
  theme_bw()

## Combine
tree_all <- tree_c3 %>% 
  full_join(tree_c4, by = c("plotID", "treeID", "itemNo"), suffix = c("_c3", "_c4"))


tt <- tree_all %>%
  select(
    plotID, treeID, itemNo, 
    ScName_c3, LuseType.EN_c3, dbh_c3, h_c3,
    ScName_c4, LuseType.EN_c4, dbh_c4, h_c4,
    ) %>%
  slice_head(n = 10)


ggplot(tree_all) +
  geom_segment(
    mapping = aes(x = dbh_c3,  xend = dbh_c4, y = h_c3, yend = h_c4), 
    arrow = arrow(length=unit(0.30,"cm"), type = "closed")
    ) +
  # geom_point(aes(x = dbh_c3, y = h_c3), col = "darkred") +
  # geom_point(aes(x = dbh_c4, y = h_c4), col = "red") +
  # facet_wrap(~plotID) +
  theme_bw() +
  labs(
    x ="Diameter at breast height (cm)", 
    y = "Tree total height (m)"
    )

summary(tree_all$dbh_c3)
summary(tree_all$dbh_c4)
summary(tree_all$h_c3)
summary(tree_all$h_c4)

## Flag errors - ADD POM 
tree_all <- tree_c3 %>% 
  full_join(tree_c4, by = c("plotID", "treeID", "itemNo"), suffix = c("_c3", "_c4")) %>%
  mutate(
    flag_dbh = case_when(
      dbh_c3 > dbh_c4  ~ "FLAG",
      dbh_c3 < dbh_c4  ~ "Ok",
      dbh_c3 == dbh_c4 ~ "No growth",
      TRUE ~ NA_character_
      ),
    flag_species = if_else(ScName_c3 == ScName_c4, "Ok", "FLAG")
    )

table(tree_all$flag_dbh, useNA = "always")
table(tree_all$flag_species, useNA = "always")


## Check species
tt <- tree_all %>%
  filter(flag_species == "FLAG") %>%
  select(plotID, treeID, itemNo, ScName_c3, ScName_c4)


## Exercise
## EX1. Recreate 'tree_all' and:
##  - Remove pseudoTree
##  - Complete the column 'flag_dbh' with recruitment/mortality:
##    + "Recruitment" when tree not in c3 and in c4 tip: use 'is.na(dbh_c3)'
##    + "Dead" when tree in c3 but not in c4
## EX3. Recreate the arrow figure only for DBH 'FLAG' trees.

tree_all <- tree_c3 %>% 
  full_join(tree_c4, by = c("plotID", "treeID", "itemNo"), suffix = c("_c3", "_c4")) %>%
  #filter(ScName_c3 != "pseudoTree", ScName_c4 != "pseudoTree") %>%
  mutate(
    flag_dbh = case_when(
      is.na(dbh_c3)    ~ "Recruitment",
      is.na(dbh_c4)    ~ "Dead",
      dbh_c3 > dbh_c4  ~ "FLAG",
      dbh_c3 < dbh_c4  ~ "Ok",
      dbh_c3 == dbh_c4 ~ "No growth",
      TRUE ~ NA_character_
    ),
    flag_h = case_when(
      h_c3 > h_c4  ~ "FLAG",
      h_c3 < h_c4  ~ "Ok",
      h_c3 == h_c4 ~ "No growth",
      is.na(h_c3)  ~ "Recruitment",
      is.na(h_c4)  ~ "Dead",
      TRUE ~ NA_character_
    ),
    flag_species = if_else(ScName_c3 == ScName_c4, "Ok", "FLAG")
  )

tree_all %>% filter(is.na(dbh_c4)) %>% select(ScName_c3, ScName_c4)

## Bad trees
tree_all %>%
  filter(flag_dbh == "FLAG" | flag_h == "FLAG") %>%
  ggplot() +
  geom_segment(
    mapping = aes(x = dbh_c3, xend = dbh_c4, y = h_c3, yend = h_c4),
    arrow = arrow(length=unit(0.20,"cm"), type = "closed")
    ) + 
  theme_bw()

## Good trees
tree_all %>%
  filter(flag_dbh != "FLAG" & flag_h != "FLAG") %>%
  ggplot() +
  geom_segment(
    mapping = aes(x = dbh_c3, xend = dbh_c4, y = h_c3, yend = h_c4),
    arrow = arrow(length=unit(0.20,"cm"), type = "closed")
  ) + 
  theme_bw()

## All together
tree_all %>%
  #filter(flag_dbh != "FLAG" & flag_h != "FLAG") %>%
  ggplot() +
  geom_segment(
    mapping = aes(x = dbh_c3, xend = dbh_c4, y = h_c3, yend = h_c4, color = flag_dbh),
    arrow = arrow(length=unit(0.2,"cm"), type = "closed", angle = 30)
  ) + 
  theme_bw()

