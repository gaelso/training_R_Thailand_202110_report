
table(tree_all$flag_dbh)

## Convert azimuth to radian
tree_map <- tree_all %>%
  mutate(
    angle_c3 = pi - as.numeric(Azimuth_c3) * pi / 180,
    angle_c4 = pi - as.numeric(Azimuth_c4) * pi / 180
  )

unique(tree_map$plotID)

## Map with azimuth
tree_map %>% 
  filter(plotID == "474446662001305C") %>% 
  ggplot() +
  geom_point(aes(x = angle_c3, y = as.numeric(Distance_c3), color = as.numeric(Azimuth_c3)), shape = 1, size = 2) +
  geom_point(aes(x = angle_c4, y = as.numeric(Distance_c4), color = as.numeric(Azimuth_c4)), shape = 3, size = 2) +
  geom_hline(yintercept = 17.84, color = "darkred") +
  geom_hline(yintercept = 12.62, color = "darkred") +
  geom_hline(yintercept = 3.99, color = "darkred") +
  scale_x_continuous(
    expand = c(0, 0), 
    limits = c(-pi, pi),
    breaks = c(-2:2) * pi/2,
    labels = c("360", "270", "180", "90", "0")
  ) +
  coord_polar(theta = "x", start = 0, direction = -1) +
  theme_bw() +
  theme(legend.position = "none")

## Map with flag
tree_map %>% 
  filter(plotID == "474446662001305C") %>% 
  ggplot() +
  geom_point(aes(x = angle_c3, y = as.numeric(Distance_c3), color = flag_dbh), shape = 1, size = 2) +
  geom_point(aes(x = angle_c4, y = as.numeric(Distance_c4), color = flag_dbh), shape = 3, size = 2) +
  geom_hline(yintercept = 17.84, color = "darkred") +
  geom_hline(yintercept = 12.62, color = "darkred") +
  geom_hline(yintercept = 3.99, color = "darkred") +
  scale_x_continuous(
    expand = c(0, 0), 
    limits = c(-pi, pi),
    breaks = c(-2:2) * pi/2,
    labels = c("360", "270", "180", "90", "0")
  ) +
  coord_polar(theta = "x", start = 0, direction = -1) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(x = "", y = "Distance (m)", color = "")
