
## Calculate AGB at land use level (Simple Average)
lu_agb <- plot_agb %>%
  group_by(landuseTypeCode) %>%
  summarise(
    n_plot = n(),
    agb_lu = round(mean(agb), 3),
    sd     = sd(agb)
  ) %>%
  mutate(
    ci      = sd / sqrt(n_plot) * 1.96,
    ci_perc = round(ci / agb_lu * 100, 0)
  ) %>%
  left_join(lu_init %>% select(-Remark), by = c("landuseTypeCode" = "LuseCode"))
