
## Calculating Overall carbon stock

overall_dbh <- tree3 %>%
  filter(landuseTypeCode %in% c(111, 112, 113, 121, 122)) %>%
  pull(dbh)

summary(overall_dbh)
mean(overall_dbh)
sd(overall_dbh)
cv_dbh <-  sd(overall_dbh) / mean(overall_dbh)
cv_dbh

table(plot_agb$landuseTypeCode)

agb_means <- plot_agb %>%
  group_by(landuseTypeCode) %>%
  summarise(count = n(), mean_agb = mean(agb), sd_agb = sd(agb)) %>%
  mutate(cv = round(sd_agb / mean_agb, 2))

overall_agb <- plot_agb %>%
  filter(landuseTypeCode %in% c(111, 112, 113, 121, 122)) %>%
  pull(agb)

summary(overall_agb)
mean(overall_agb)
sd(overall_agb)

cv_agb <- sd(overall_agb) / mean(overall_agb)
cv_agb


nplot1 <- (cv_dbh * 1.96/ 0.05)^2
nplot1

nplot1 <- (cv_dbh * 1.96/ 0.1)^2
nplot1


nplot2 <- (cv_agb * 1.96 / 0.05)^2
nplot2

nplot2 <- (cv_agb * 1.96 / 0.1)^2
nplot2




#####

str <- c("AABBCCCCDDD", "ADCDEEE")

str_count(str_to_lower(str), "a")


tt <- map(letters, function(x){
  
  str_count(str_to_lower(str), x) 

})

tt2 <- unlist(tt)

res <- length(tt2[tt2 == 2]) * length(tt2[tt2==3])
res


