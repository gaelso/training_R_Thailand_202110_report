
## Load library
library(Hmisc)
library(tidyverse)

## Custom function to remove labels from mdb.get()
rm_labels <- function(x){
  for(i in 1 : dim(x)[2]) class(x[[i]]) <- setdiff(class(x[[i]]), 'labelled') 
  for(i in 1 : dim(x)[2]) attr(x[[i]],"label") <- NULL
  return(x)
}



## Convert original files -------------------------------------------------------------

list_table <- mdb.get("data/Obluang_10x10_5plot_2021/Obluang_10x10_5plot_2021.mdb", tables = T)
mdb_data   <- mdb.get("data/Obluang_10x10_5plot_2021/Obluang_10x10_5plot_2021.mdb")

walk(list_table, function(x){
  tmp <- mdb_data[[x]] %>% rm_labels()
  write_csv(tmp, paste0("data/Obluang_10x10_5plot_2021/", x, ".csv"))
})

