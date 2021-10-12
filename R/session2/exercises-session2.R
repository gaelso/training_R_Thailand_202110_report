

## Exercises for the Session2

## IVI

source("R/session2/forest-ivi-function.R")

## -- 1. Calculate IVI for the top 20 species in Tropical Evergreen forest
ivi_data <- tree %>% filter(landuseTypeCode == 111)

ivi_ev <- calc_ivi(.data = ivi_data, .plot_area = 0.1)
ivi_ev

## Save the results ----
write_csv(ivi_ev, "results/species_ivi20_tropev.R")



## -- 2. Calculate IVI for the top 10 species in Kaeng Krung National Park (requires plot details in 'data' folder)
list.files("data")
index <- read_csv("data/Index_NFI_20211007.csv")

index_kk <- index %>% 
  filter(Name_En == "Kaeng Krung", Type_Code == "NPRK") %>%
  select(plotID = PlotId_WGS, park_name = Name_En)

tree_kk <- tree %>%
  left_join(index_kk, by = "plotID") %>%
  filter(!is.na(park_name))

length(unique(tree_kk$plotID))

ivi_kk <- calc_ivi(.data = tree_kk, .plot_area = 0.1, .num_species = 10)
ivi_kk



## -- 3. Create graph h vs dbh for the each of the 4 most important species in Kaeng Krung National Park.
ivi_kk4 <- ivi_kk %>%
  slice_head(n = 4) %>%
  select(ScName, IVI)

tree_kk %>%
  left_join(ivi_kk4, by = "ScName") %>%
  filter(!is.na(IVI)) %>%
  ggplot(aes(x = dbh, y = h, color = ScName)) +
  geom_point() +
  theme_bw()



