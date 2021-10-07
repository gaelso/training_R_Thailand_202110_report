
## Main script to source non-carbon forest indicators 


## Load packages
library(tidyverse)
library(ggrepel)
library(ggpubr)


## Read data and filter trees in the 10 km grid
source("R/session2/load-data.R")


## Calculate IVI
source("R/session2/forest-ivi.R")


## Tree density per diameter class
source("R/session2/forest-density-dbh.R")
