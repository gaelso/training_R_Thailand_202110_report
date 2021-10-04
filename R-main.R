## Follow-up training on R for forestry data analysis
## Gael Sola, FAO
## June 2021

## Main script


## User defined variables ------

## Nothing yet

## -----------------------------


## Sourcing scripts

## --- Setup
source("R/00-libs.R")

## --- Data collection


## --- Data processing
source("R/load-data.R")



## TREE DATA ANALYSIS

## --- Data cleaning
source("R/data-cleaning-tree.R")

## --- Exploratory data analysis
source("R/tree-agb.R")

source("R/plot-agb.R")

source("R/lu-agb.R")

## --- Modeling

## --- Data products

## --- Communication
source("R/figures.R")
source("R/figures2.R")



## BAMBOO DATA ANALYSIS
source("R-Bamboo/data-cleaning-bamboo.R")
source("R-Bamboo/bamboo-plot.R")
source("R-Bamboo/bamboo-lu.R")
source("R-Bamboo/communication.R")


