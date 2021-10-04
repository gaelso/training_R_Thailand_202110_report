

## Publication ready figures

## --- Default figure
ggplot(plot_agb) + 
  geom_point(aes(x = ba, y = agb, color = landuseTypeCode))


## --- Add labels -----------------------------------------------------------
ggplot(plot_agb) + 
  geom_point(aes(x = ba, y = agb, color = landuseTypeCode)) +
  labs(
    x = "Basal area (m2/ha)", 
    y = "Aboveground biomass (t/ha)",
    color = "Land use code",
    title = "This is my graph...",
    subtitle = "...and it looks good",
    caption = "Some comment here\n on two lines"
    )

ggplot(plot_agb) + 
  geom_point(aes(x = ba, y = agb, color = landuseTypeCode)) +
  labs(
    x = "พื้นที่หน้าตัด (m2/ha)", 
    y = "มวลชีวภาพเหนือพื้นดิน (t/ha)"
  ) +
  theme_bw() +
  theme(text = element_text(family = "Sarabun")) +
  theme(legend.position = "none")




ggplot(plot_agb) + 
  geom_point(aes(x = ba, y = agb, color = landuseTypeCode)) +
  labs(
    x = "พื้นที่หน้าตัด (m2/ha)", 
    y = "มวลชีวภาพเหนือพื้นดิน (t/ha)",
    color = "การใช้ประโยชน์ที่ดิน",
    title = "แผนภาพแสดงพื้นที่หน้าตัดต่อมวลชีวภาพเหนือพื้นดิน",
    subtitle = "หน่วย m2/ha ต่อ t/ha",
    caption = "กรมอุทยานแห่งชาติ สัตว์ป่า และพันธุ์พืช"
  ) +
  ggpubr::theme_pubr() +
  theme(text = element_text(family = "Sarabun"))

## Using html code for customization
my_caption <- '<span style="color:red;">First part of caption</span><br><span style="color:orange;">Second part of caption</span>'

ggplot(plot_agb) + 
  geom_point(aes(x = ba, y = agb, color = landuseTypeCode)) +
  labs(
    x = "Basal area (m2/ha)", 
    y = "Aboveground biomass (t/ha)",
    color = "Land use code",
    title = "This is my graph...",
    subtitle = "...and it looks good",
    caption = my_caption
  ) +
  theme(plot.caption = ggtext::element_textbox(hjust = 0))


## --- Present outliers -----------------------------------------------------
outliers <- plot_agb %>%
  filter(agb > 500)

ggplot(plot_agb, aes(x = ba, y = agb)) + 
  geom_point() +
  geom_point(data = outliers, color = "red", shape = 1, size = 6) +
  labs(
    x = "Basal area (m2/ha)", 
    y = "Aboveground biomass (t/ha)"
  )


ggplot(plot_agb, aes(x = ba, y = agb)) + 
  geom_point() +
  geom_point(data = outliers, color = "red", shape = 1, size = 6) +
  ggrepel::geom_label_repel(data = outliers, 
                            aes(label = plotID), 
                            point.padding = 6, color = 'red') +
  labs(
    x = "Basal area (m2/ha)", 
    y = "Aboveground biomass (t/ha)"
  )


outliers <- plot_agb %>%
  filter(agb > 300, ba > 45)
ggplot(plot_agb, aes(x = ba, y = agb)) + 
  geom_point() +
  geom_point(data = outliers, color = "red", shape = 1, size = 6) +
  ggrepel::geom_label_repel(data = outliers, aes(label = plotID), max.overlaps = Inf, box.padding = 0.5) +
  labs(
    x = "Basal area (m2/ha)", 
    y = "Aboveground biomass (t/ha)"
  )

# ggplot(plot_agb, aes(x = ba, y = agb)) + 
#   geom_point() +
#   geom_point(data = outliers, color = "red", shape = 1, size = 6) +
#   geom_label(data = outliers, aes(label = plotID), max.overlaps = Inf, box.padding = 0.5) +
#   labs(
#     x = "Basal area (m2/ha)", 
#     y = "Aboveground biomass (t/ha)"
#   )


## --- Combine graphs -------------------------------------------------------
gr1 <- plot_agb %>%
  filter(!(landuseTypeCode %in% 114:115)) %>%
  ggplot(aes(x = landuseTypeCode, y = agb, color = landuseTypeCode, shape = landuseTypeCode)) +
  geom_boxplot() +
  labs(
    x = "Land use code", 
    y = "Aboveground biomass (t/ha)",
    color = "Land use code",
    shape = "Land use code"
  )
gr1

gr2 <- plot_agb %>%
  filter(!(landuseTypeCode %in% 114:115)) %>%
  ggplot(aes(x = ba, y = agb, color = landuseTypeCode, shape = landuseTypeCode)) +
  geom_point() +
  labs(
    x = "Basal area (m2/ha)", 
    y = "",
    color = "Land use code",
    shape = "Land use code"
  )
gr2

gr <- ggpubr::ggarrange(gr1, gr2)
gr

gr <- ggpubr::ggarrange(gr1, gr2, align = "hv", common.legend = TRUE)
gr

gr <- ggpubr::ggarrange(
  gr1, gr2, align = "hv", common.legend = TRUE, legend = 'bottom', labels = c("A", "B")
  )
gr


## --- Theme ----------------------------------------------------------------
gr1 + theme_bw()
gr1 + theme_minimal()
gr1 + theme_void()
gr1 + ggdark::dark_theme_bw()
invert_geom_defaults()
gr1 + theme_light()

gr1 + ggpubr::theme_classic2()

## EX #######################################################################

outliers <- plot_agb %>% filter(agb > 400)
  
gr11 <- ggplot(plot_agb, aes(x = ba, y = agb)) +
  geom_point(shape = 3) +
  geom_point(data = outliers, shape = 1, size = 6, color = 'forestgreen') +
  ggrepel::geom_label_repel(
    data = outliers, 
    aes(label = plotID), 
    color = "forestgreen", point.padding = 6
    ) +
  theme_bw() +
  labs(
    x = "Basal area (m2/ha)",
    y = "Aboveground Biomass (t/ha)"
  )
gr11


gr12 <- tree3 %>%
  filter(plotID %in% outliers$plotID) %>%
  ggplot(aes(x = dbh, y = h, color = plotID)) +
  geom_point(shape = 18, size = 3) +
  theme_bw() +
  labs(
    x = "Diameter at breast height (cm)",
    y = "Tree total height (m)",
    color = "Plot ID"
  )
gr12

gr10 <- ggarrange(gr11, gr12, labels = c("A", "B"), 
                  align = "hv", legend = "bottom", common.legend = T)
gr10




