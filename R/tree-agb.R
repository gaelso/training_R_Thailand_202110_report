
## Exercise open the R project to calculate the carbon stock for FREL/FRL,
## copy/paste the code to get tree AGB and edit 'h_corr' to 'h' 

check <- tree %>% select(landuseTypeCode, LuseType.EN) %>% distinct()

tree3 <- tree2 %>%
  mutate(
    ogawa_trop_tc = 0.0396 * (dbh^2 * h)^0.9326 + 0.006002 * (dbh^2 * h)^1.027,
    ogawa_trop    = ogawa_trop_tc + (18.0 / ogawa_trop_tc + 0.025)^(-1),
    ogawa_md_tc   = 0.0396 * (dbh^2 * h)^0.9326 +  0.003487 * (dbh^2 * h)^1.027,
    ogawa_md      = ogawa_md_tc + (28.0 / ogawa_md_tc + 0.025)^(-1),
    tsutsumi      = 0.0509 * d2h^0.919 + 0.00893 * d2h^0.977 + 0.0140 * d2h^0.669,
    agb_thai           = case_when(
      LuseType.EN == "Tropical Evergreen Forest" ~ ogawa_trop,
      LuseType.EN == "Mixed Deciduous Forest"    ~ ogawa_md,
      LuseType.EN == "Dry Dipterocarp Forest"    ~ ogawa_md,
      LuseType.EN == "Hill Evergreen Forest"     ~ tsutsumi,
      LuseType.EN == "Dry Evergreen Forest"      ~ tsutsumi,
      LuseType.EN == "Pine Forest"               ~ tsutsumi,
      LuseType.EN == "Peat Swamp Forest"         ~ tsutsumi,
      TRUE ~ 0
    )
  )

## Visualisation
ggplot(tree3) +
  geom_point(aes(x = dbh, y = agb_thai, color = LuseType.EN))

ggplot(tree3) +
  geom_point(aes(x = dbh, y = agb_thai, color = LuseType.EN)) +
  facet_wrap(~LuseType.EN)

ggplot(tree3) +
  geom_point(aes(x = dbh, y = agb_thai, color = LuseType.EN)) +
  facet_wrap(~LuseType.EN) +
  theme(legend.position = 'none')

ggplot(tree3) +
  geom_line(aes(x = d2h, y = agb_thai, color = LuseType.EN))

ggplot(tree3) +
  geom_boxplot(aes(x = LuseType.EN, y = agb_thai))

tree3 %>%
  filter(agb_thai < 100) %>%
  ggplot(aes(x = LuseType.EN, y = agb_thai)) +
  geom_boxplot()
