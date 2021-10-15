
## Load packages
library(sf)
library(tmap)
library(tidyverse)


## Read data
sf_admin <- st_read("data/Thailand_Admin_BDR/Geo_Province.shp")
sf_prtc  <- st_read("data/PRTC/prtc_join_2018.shp")

## Check data
table(st_is_valid(sf_admin))
table(st_is_valid(sf_prtc))

sf_admin
sf_prtc

## Modify data
sf_province <- sf_admin %>%
  group_by(PROV_CODE, PROV_NAM_T, PROV_NAM_E) %>%
  summarise(AREA = sum(AREA)) %>%
  st_simplify(dTolerance = 100)

sf_country <- sf_admin %>% 
  st_union() %>% 
  st_simplify(dTolerance = 100)

sf_petchaburi <- sf_admin %>%
  filter(PROV_NAM_E == "Changwat Phetchaburi") %>%
  st_union() %>% 
  st_simplify(dTolerance = 100)

## Visualize data
ggplot() +
  geom_sf(data = sf_province, aes(fill = PROV_NAM_T), col = NA) +
  geom_sf(data = sf_country, fill = NA, col = "black", size = 1) +
  geom_sf(data = sf_petchaburi, fill = "red", col = "darkred", size = 1) +
  theme_void() +
  theme(legend.position = "none")

ggplot() +
  geom_sf(data = sf_prtc, aes(fill = Type_th)) +
  geom_sf(data = sf_country, fill = NA, col = "black") +
  theme_void() +
  labs(fill = "")

ggplot() +
  geom_sf(data = sf_prtc, aes(fill = Type_th)) +
  geom_sf(data = sf_country, fill = NA, col = "black") +
  theme_void() +
  labs(fill = "") +
  coord_sf(xlim = c(425237.6, 525237.6), ylim = c(1000000, 1100000), expand = FALSE)

tmap_mode("plot")
tm_shape(sf_country) + tm_borders() +
tm_shape(sf_prtc) + tm_polygons(col = "Type_th") +
  tm_compass(type = "4star", position = c("right", "top"), size = 2) +
  tm_scale_bar(breaks = c(0, 100, 200), text.size = 1)

tmap_mode("view")
tm_shape(sf_country) + tm_borders() #+
  #tm_shape(sf_prtc) + tm_polygons(col = "Type_th")


