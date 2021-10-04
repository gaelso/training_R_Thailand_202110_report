

## Barplot ##################################################################

lu_agb %>%
  ggplot(aes(x = LuseType.EN, y = agb_lu)) +
  geom_col()


lu_agb %>% select(landuseTypeCode, LuseType.EN) %>% arrange(landuseTypeCode)

lu_agb %>%
  mutate(
    lu_en = factor(
      x = LuseType.EN, 
      levels = c(
        "Tropical Evergreen Forest", "Dry Evergreen Forest", "Hill Evergreen Forest",
        "Pine Forest", "Peat Swamp Forest", "Mixed Deciduous Forest", "Dry Dipterocarp Forest"
      )
    )
  ) %>%
  ggplot(aes(x = agb_lu, y = lu_en)) +
  geom_col()



lu_agb %>%
  mutate(lu_en = fct_reorder(LuseType.EN, landuseTypeCode)) %>%
  ggplot(aes(x = lu_en, y = agb_lu, fill = lu_en)) +
  geom_col(color = "black") +
  geom_errorbar(aes(ymin = agb_lu - ci, ymax = agb_lu + ci), width = 0.6) +
  geom_label(aes(y = agb_lu + ci + 15, label = n_plot), fill = 'white') +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  scale_fill_viridis_d() +
  theme_bw() +
  theme(legend.position = "none") +
  labs(
    x = "",
    y = "Mean aboveground biomass (t/ha)",
    caption = "Labels indicate the number of plots"
  )


## Points and lines #########################################################
