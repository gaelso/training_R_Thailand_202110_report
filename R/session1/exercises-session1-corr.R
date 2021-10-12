
## Practice for the Session 1

## Load packages ------
## Load the package tidyverse. Install first only if necessary
library(tidyverse)

## Read data ------
## EX: Read the bamboo table in 'bamboo' object
bamboo <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblBamboo.csv")

## EX: Read the erect rattan table in 'rattan' object
rattan <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblErectRattan.csv")


## EXERCISE 1. visualize data
## -- 1.1 In the table 'tree2' create the chart Height vs GBH.
tree <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblTree.csv")

tree2 <- slice_head(tree, n = 200)

ggplot(tree2, aes(x = GBH, y = Height)) +
  geom_point() +
  theme_bw()

## -- 1.2 Create the table 'outliers' with: GBH > 200 and Height > 20
outliers <- tree2 %>%
  filter(GBH > 200, Height > 20)

outliers2 <- tree %>%
  filter(GBH > 200, Height < 10)

outliers3 <- tree %>%
  filter(GBH < 30, Height > 20)

outliers4 <- tree2 %>%
  filter(GBH > 100, Height < 20)

## -- 1.3 Create the chart Height vs GBH for 'outliers' with red circle, size 5.
gr_outliers <- ggplot() +
  geom_point(data = outliers, aes(x = GBH, y = Height),color = "red", shape = 1, size = 5) +
  theme_bw()
gr_outliers

ggplot(outliers, aes(x = GBH, y = Height)) +
  geom_point(color = "red", shape = 1, size = 5) +
  theme_bw()

## -- 1.4 Create the chart Height vs GBH combining both 'tree2' and 'outliers'.
gr_comb <- ggplot() +
  geom_point(data = tree2, aes(x = GBH, y = Height)) +
  geom_point(data = outliers, aes(x = GBH, y = Height),color = "red", shape = 1, size = 5) +
  geom_point(data = outliers4, aes(x = GBH, y = Height),color = "green", shape = 2, size = 5) +
  theme_bw()
gr_comb


gr_comb2 <- ggplot(tree2, aes(x = GBH, y = Height)) +
              geom_point() +
              geom_point(data = outliers, color = "red", shape = 1, size = 5) +
              theme_bw()
gr_comb2
           
  
## -- 1.5 In the table 'rattan' create the chart avgLength vs avgGBH, with color based on Species Code.
gr_rattan <- ggplot() +
  geom_point(data = rattan, aes(x = avgGBH, y = avgLength, color = as.character(speciesCode))) +
  theme_bw() +
  theme(legend.position = "none")
gr_rattan

ggplot(rattan, aes(x = avgGBH, y = avgLength, color = as.character(speciesCode))) +
  geom_point() +
  theme_bw() +
  theme(legend.position = "none")



## -- 1.6 In the table 'bamboo' create the chart Length vs GBH, color based on number of culms.
gr_bamboo <- ggplot() +
  geom_point(data = bamboo, aes(x = bambooGBH, y = bambooLength, color = as.character(numOfCulms))) +
  theme_bw() +
  theme(legend.position = "none")
gr_bamboo

ggplot(bamboo, aes(x = bambooGBH, y = bambooLength, color = as.character(numOfCulms))) +
  geom_point() +
  theme_bw() +
  theme(legend.position = "none")



## -- 1.7 In the last graph change the color palette to viridis colors.
bamboo %>%
  filter(bambooGBH < 150, bambooLength < 30) %>%
  ggplot() +
  geom_point(aes(x = bambooGBH, y = bambooLength, color = as.character(numOfCulms))) +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = "none")



## EXERCISE 2. modify data
## -- 2.1 create table 'tree3' from 'tree2'.
tree3 <- tree2 

## -- 2.2 filter only live trees and remove pseudo-trees (speciesCode = 11).
tree3 <- tree2 %>%
  filter(liveDead == "L",
         speciesCode != 11)

## -- 2.3 calculate tree basal area.
tree3 <- tree2 %>%
  filter(liveDead == "L",
         speciesCode != 11) %>%
  mutate(dbh = GBH / pi,
         ba  = (dbh/2)^2/10000 * pi)
  

## -- 2.4 create 'rattan2' from 'rattan' and filter only the species 23383.
rattan2 <- rattan %>%
  filter(speciesCode == 23383)

## -- 2.5 calculate the basal area of rattan2.
rattan2 <- rattan %>%
  filter(speciesCode == 23383) %>%
  mutate(ba_stem   = avgGBH^2 / (pi * 10000),
         ba_rattan = stems * ba_stem)


## EXERCISE 3. save the results
## -- 3.1 create folder results
dir.create("results", showWarnings = FALSE)

## -- 3.2 save the results 'tree3' as tree_basal.csv in folder results
write_csv(tree3, "results/tree_basal.csv")

## -- 3.3 save 'rattan2' in the folder results
write_csv(rattan2, "results/rattan2.csv")


ggsave(gr_comb,
       filename = "results/gr_comb.png",
       width = 15, height = 12, units = "cm", dpi = 300)
