

## Load packages ------

library(tidyverse)



## Read data ------

tree <- read_csv("data/Cycle3_DNP_2013-2017_2.5x2.5_C_3921_plot/tblTree.csv")



## Visualize data ------

tree
summary(tree)

## Number of rows?
nrow(tree)

## That's too much we will reduce to the first 200 trees
tree2 <- slice_head(tree, n = 200)

## Back to visualization
ggplot(tree2, aes(x = GBH, y = Height, color = CrownCondition)) +
  geom_point() +
  theme_bw()



## Modify the data ------

## modify the table
tree3 <- tree2 %>%
  mutate(dbh = round(GBH/pi, 0))

## Select only a few columns
tree3 <- tree3 %>%
  select(dbh, h = Height, crown_condition = CrownCondition)

## Subset
tree3 <- tree3 %>%
  filter(dbh < 50)

## See the results
ggplot(tree3, aes(x = dbh, y = h, color = crown_condition)) +
  geom_point() +
  theme_bw()



## Save the results ----

write_csv(tree3, "results/session1/tree3.csv")


## Tip: with the pipe operator, we can actually run the whole chain at once
tree4 <- tree2 %>%
  mutate(dbh = round(GBH/pi, 0)) %>%
  select(dbh, h = Height, crown_condition = CrownCondition) %>%
  filter(dbh < 50)

ggplot(tree4, aes(x = dbh, y = h, color = crown_condition)) +
  geom_point() +
  theme_bw()
