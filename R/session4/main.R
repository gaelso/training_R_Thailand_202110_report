
## Main script to source non-carbon forest indicators 


## Load packages
library(tidyverse)
library(ggrepel)
library(ggpubr)


## Read data and filter trees in the 10 km grid
source("R/session4/load-data-c3.R")
source("R/session4/load-data-c4.R")

## Calculate plot level comparisons
source("R/session4/.R")
