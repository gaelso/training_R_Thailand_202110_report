
## Calc AGB
tree_agb <- tree_all %>%
  mutate(
    ogawa_trop_tc = 0.0396 * (dbh_c3^2 * h_c3)^0.9326 + 0.006002 * (dbh_c3^2 * h_c3)^1.027,
    ogawa_trop    = ogawa_trop_tc + (18.0 / ogawa_trop_tc + 0.025)^(-1),
    ogawa_md_tc   = 0.0396 * (dbh_c3^2 * h_c3)^0.9326 +  0.003487 * (dbh_c3^2 * h_c3)^1.027,
    ogawa_md      = ogawa_md_tc + (28.0 / ogawa_md_tc + 0.025)^(-1),
    tsutsumi      = 0.0509 * d2h_c3^0.919 + 0.00893 * d2h_c3^0.977 + 0.0140 * d2h_c3^0.669,
    agb_thai_c3 = case_when(
      LuseType.EN_c3 == "Tropical Evergreen Forest" ~ ogawa_trop,
      LuseType.EN_c3 == "Mixed Deciduous Forest"    ~ ogawa_md,
      LuseType.EN_c3 == "Dry Dipterocarp Forest"    ~ ogawa_md,
      LuseType.EN_c3 == "Hill Evergreen Forest"     ~ tsutsumi,
      LuseType.EN_c3 == "Dry Evergreen Forest"      ~ tsutsumi,
      LuseType.EN_c3 == "Pine Forest"               ~ tsutsumi,
      LuseType.EN_c3 == "Peat Swamp Forest"         ~ tsutsumi,
      TRUE ~ 0
    )
  ) %>% 
  mutate(
    ogawa_trop_tc = 0.0396 * (dbh_c4^2 * h_c4)^0.9326 + 0.006002 * (dbh_c4^2 * h_c4)^1.027,
    ogawa_trop    = ogawa_trop_tc + (18.0 / ogawa_trop_tc + 0.025)^(-1),
    ogawa_md_tc   = 0.0396 * (dbh_c4^2 * h_c4)^0.9326 +  0.003487 * (dbh_c4^2 * h_c4)^1.027,
    ogawa_md      = ogawa_md_tc + (28.0 / ogawa_md_tc + 0.025)^(-1),
    tsutsumi      = 0.0509 * d2h_c4^0.919 + 0.00893 * d2h_c4^0.977 + 0.0140 * d2h_c4^0.669,
    agb_thai_c4 = case_when(
      LuseType.EN_c4 == "Tropical Evergreen Forest" ~ ogawa_trop,
      LuseType.EN_c4 == "Mixed Deciduous Forest"    ~ ogawa_md,
      LuseType.EN_c4 == "Dry Dipterocarp Forest"    ~ ogawa_md,
      LuseType.EN_c4 == "Hill Evergreen Forest"     ~ tsutsumi,
      LuseType.EN_c4 == "Dry Evergreen Forest"      ~ tsutsumi,
      LuseType.EN_c4 == "Pine Forest"               ~ tsutsumi,
      LuseType.EN_c4 == "Peat Swamp Forest"         ~ tsutsumi,
      TRUE ~ 0
    )
  )


## Visualisation
gr1 <- ggplot(tree_agb) +
  geom_point(aes(x = dbh_c3, y = agb_thai_c3, color = LuseType.EN_c3)) +
  xlim(0, 80) + ylim(0, 2500) +
  theme_bw()

gr2 <- ggplot(tree_agb) +
  geom_point(aes(x = dbh_c4, y = agb_thai_c4, color = LuseType.EN_c4)) +
  xlim(0, 80) + ylim(0, 2500) +
  theme_bw()

ggarrange(gr1, gr2, nrow = 1, align = "hv", common.legend = T)
