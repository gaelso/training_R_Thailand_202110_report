## Data preparation script
## Also used to practice tidyverse functions

## --- Solve parsing failures with loading everything as character
lu_init      <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblLanduse.csv", col_types = cols(.default = col_character()))
cluster_init <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblCluster.csv", col_types = cols(.default = col_character()))
plot_init    <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblGenInfo.csv", col_types = cols(.default = col_character()))
tree_init    <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblTree.csv"   , col_types = cols(.default = col_character()))
species_list <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblPlant.csv"  , col_types = cols(.default = col_character()))


## Get land use and NFI grid in plot ########################################
plot <- plot_init %>%
  left_join(cluster_init %>% select(ClusterID = clusterId, SIZE), by = "ClusterID") %>%
  left_join(lu_init %>% select(-Remark) , by = c("landuseTypeCode" = "LuseCode")) %>%
  select(plotID, tDate, East.GPS, North.GPS, landuseTypeCode, SIZE, LuseType.TH, LuseType.EN) %>%
  filter(as.numeric(landuseTypeCode) < 130, SIZE == "10x10")


## Get plot info to tree ####################################################
tree <- tree_init %>%
  left_join(plot, by = "plotID")%>%
  left_join(species_list %>% select(speciesCode = PCode, ScName, Type), by = "speciesCode") %>%
  filter(
    !is.na(landuseTypeCode),
    ScName != "pseudoTree") %>%
  mutate(
    dbh          = round(as.numeric(GBH)/pi, 0),
    h            = as.numeric(Height),
    ba_tree      = round((dbh/200)^2 * pi, 2),
    d2h          = dbh^2 * h,
    scale_factor = 10
  )

table(tree$landuseTypeCode, useNA = 'always')
summary(tree$dbh)
summary(tree$h)




