
## Practice for the Session 1

## Load packages ------
## Load the package tidyverse. Install first only if necessary


## Read data ------
## EX: Read the bamboo table in 'bamboo' object
## EX: Read the erect rattan table in 'rattan' object

bamboo <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblBamboo.csv")
rattan <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblerectRattan.csv")

## EXERCISE 1. visualize data
## -- 1.1 In the table 'tree2' create the chart Height vs GBH.
## -- 1.2 Create the table 'outliers' with: GBH > 200 and Height > 20
## -- 1.3 Create the chart Height vs GBH for 'outliers' with red circle, size 5.
## -- 1.4 Create the chart Height vs GBH combining both 'tree2' and 'outliers'.
## -- 1.5 In the table 'rattan' create the chart avgLength vs avgGBH, with color based on Species Code.
ggplot(rattan) +
  geom_point(aes(x = avgLength, y = avgGBH, color = as.character(speciesCode))) +
  theme_bw() +
  theme(legend.position = "none")

## -- 1.6 In the table 'bamboo' create the chart Length vs GBH, color based on number of culms.
bamboo %>%
  filter(bambooGBH < 150, bambooLength < 30) %>%
  ggplot() +
  geom_point(aes(x = bambooGBH, y = bambooLength, color = as.character(numOfCulms))) +
  scale_color_viridis_d() +
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
## -- 2.2 filter only live trees and remove pseudo-trees (speciesCode = 11).
## -- 2.3 calculate tree basal area.
## -- 2.4 create 'rattan2' from 'rattan' and filter only the species 23383.
## -- 2.5 calculate the basal area of rattan2.
rattan2 <- rattan %>%
  filter(speciesCode == 23383) %>%
  mutate(
    ba_stem = avgGBH^2 / (pi * 10000),
    ba_rattan = stems * ba_stem
    )

summary(rattan2$ba_rattan)

## EXERCISE 3. save the results
## -- 3.1 create folder results
## -- 3.2 save the results 'tree2' as tree_basal.csv in folder results
## -- 3.3 save 'rattan2' in the folder results




