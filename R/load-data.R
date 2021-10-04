## Data preparation script
## Also used to practice tidyverse functions

## Load plot and tree data ##################################################
# plot_init <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblGenInfo.csv")

## --- Solve parsing failures with loading everything as character
lu_init      <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblLanduse.csv", col_types = cols(.default = col_character()))
cluster_init <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblCluster.csv", col_types = cols(.default = col_character()))
plot_init    <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblGenInfo.csv", col_types = cols(.default = col_character()))
tree_init    <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblTree.csv"   , col_types = cols(.default = col_character()))
species_list <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblPlant.csv"  , col_types = cols(.default = col_character()))

plot_init

## For bamboo
bamboo_init    <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblBamboo.csv"   , col_types = cols(.default = col_character()))

## Get land use and NFI grid in plot ########################################
plot <- plot_init %>%
  left_join(cluster_init %>% select(ClusterID = clusterId, SIZE), by = "ClusterID") %>%
  left_join(lu_init %>% select(-Remark) , by = c("landuseTypeCode" = "LuseCode")) %>%
  select(plotID, tDate, East.GPS, North.GPS, landuseTypeCode, SIZE, LuseType.TH, LuseType.EN) %>%
  filter(as.numeric(landuseTypeCode) < 130, SIZE == "10x10")

table(plot$landuseTypeCode, useNA= 'always')
table(plot$LuseType.EN, useNA= 'always')
table(plot$LuseType.TH, useNA= 'always')
table(plot$SIZE, useNA = 'always')



## Get plot info to tree ####################################################
tree <- tree_init %>%
  left_join(plot, by = "plotID")%>%
  left_join(species_list %>% select(speciesCode = PCode, ScName, Type), by = "speciesCode") %>%
  filter(!is.na(landuseTypeCode)) %>%
  mutate(
    dbh           = round(as.numeric(GBH)/pi, 0),
    h             = as.numeric(Height),
    ba_tree       = round((dbh/200)^2 * pi, 2),
    d2h           = dbh^2 * h
  )

table(tree$landuseTypeCode, useNA = 'always')
summary(tree$dbh)
summary(tree$h)


## Get plot info to bamboo ##################################################
bamboo2 <- bamboo_init %>%
  left_join(plot, by = c("plotId" = "plotID")) %>%
  left_join(species_list, by = c("speciesCode" = "PCode")) %>%
  filter(as.numeric(landuseTypeCode) < 130, SIZE == "10x10", Type == "B")

# ## Practice - Decompose the sequence into several practice steps ############
# ## PRACTICE select()
# ## --- Create the table 'nfi_grid' from 'cluster_init' with only the column 'clusterId' and 'SIZE'
# nfi_grid <- cluster_init %>% select(clusterId, SIZE) ## RECOMMENDED
# nfi_grid <- select(.data = cluster_init, clusterId, SIZE)
# 
# 
# ## PRACTICE mutate()
# ## --- Create the table 'lu' from 'lu_init' and use mutate() to create
# ##     a new column landuseTypeCode by converting LuseCode to numeric with as.numeric()
# lu <- lu_init %>% mutate(landuseTypeCode = as.numeric(LuseCode))
# 
# ## PRACTICE filter()
# ## --- Create the table 'lu2' from 'lu' with only the land use codes smaller than 130
# lu2 <- lu %>% filter(landuseTypeCode < 130)
# 
# 
# ## PRACTICE pipe sequence '%>%'
# ## --- recreate 'lu' directly from 'lu_init' by placing both filter and mutate in a sequence
# lu <- lu_init %>%
#   mutate(landuseTypeCode = as.numeric(LuseCode)) %>%
#   filter(landuseTypeCode < 130)
# 
# 
# ## Practice left_join()
# ## --- create 'plot' from 'plot_init' and join 'lu' and 'nfi_grid'
# ## --- create 'tree' from 'tree_init' and join 'plot'
# plot <- plot_init %>%
#   mutate(landuseTypeCode = as.numeric(landuseTypeCode)) %>%
#   left_join(lu) %>%
#   left_join(nfi_grid, by = c("ClusterID" = "clusterId"))
# 
# tree <- tree_init %>% left_join(plot, by = "plotID")
# 
# ## Practice mutate()
# ## --- create 'tree2' from 'tree' and and calculate tree DBH and basal area
# tree2 <- tree %>%
#   mutate(
#     dbh     = round(as.numeric(GBH) / pi, 0),
#     ba_tree = (dbh/200)^2 * pi
#   )


