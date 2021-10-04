
## Tree data cleaning #######################################################

## --- Visual checks --------------------------------------------------------
## Check outliers in DBH and H
ggplot(tree) +
  geom_point(aes(x = dbh, y = h))

tree %>%
ggplot() +
  geom_point(aes(x = dbh, y = h))

tree %>%
  ggplot(aes(x = dbh, y = h)) +
  geom_point()


## --- remove pseudotrees
tree %>%
  filter(ScName != "pseudoTree") %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h))

tree %>% filter(ScName == "pseudoTree") %>% nrow()

## --- remove not tree
tree %>%
  filter(Type == "T") %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h))

## EXERCISE
## --- Change the color of the points based on 'Type'
ggplot(tree) +
  geom_point(aes(x = dbh, y = h, colour = Type))

table(tree$Type)
## ---


## Checking other variables
ggplot(tree) +
  geom_point(aes(x = dbh, y = h, colour = liveDead))

ggplot(tree) +
  geom_point(aes(x = dbh, y = h, colour = liveDead)) +
  facet_wrap(~liveDead)

tree %>%
  mutate(liveDead = str_to_upper(liveDead)) %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h, colour = liveDead)) +
  facet_wrap(~liveDead)

## --- Update tree table ----------------------------------------------------
tree2 <- tree %>%
  filter(liveDead == "L", standFall == "S")


## PRACTICE #################################################################
## --- 1. Continue to make h vs dbh plots but change the color based on
##        land use, standing or fallen trees, number of logs, timber quality
## --- 2. What additional filters can be used to improve our table 'tree'     

tree %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h, colour = landuseTypeCode)) +
  facet_wrap(~landuseTypeCode)

tree %>%
  mutate(standFall = str_to_upper(standFall)) %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h, colour = standFall)) +
  facet_wrap(~standFall)

tree %>%
  #mutate(standFall = str_to_upper(standFall)) %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h, colour = TimberQuality)) +
  facet_wrap(~TimberQuality)

tree %>%
  #mutate(standFall = str_to_upper(standFall)) %>%
  ggplot() +
  geom_point(aes(x = dbh, y = h)) +
  facet_wrap(~NumberOfLogs)


