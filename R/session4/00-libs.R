
## Data analysis
library(tidyverse)

## Visualization
library(ggpubr)
library(ggrepel)
library(ggdark)
library(ggtext)

## Change locale to Thai
## - Open project file: .Rprofile
# file.edit(".Rprofile")

## - Write: Sys.setlocale("LC_CTYPE", "thai")
## - Go to Session / Restart R

## For Windows, check if fonts are installed and install if not
# remotes::install_version("Rttf2pt1", version = "1.3.8") ## Run 1 time

library(extrafont)

if (Sys.info()['sysname'] == "Windows") {
  
  dir.create("fonts", showWarnings = F)
  
  font_names <- c("Sarabun", "Chakra Petch")
  
  purrr::walk(font_names, function(x){

    ## Download and extract font
    if (!dir.exists(file.path("fonts", x))) {
      download.file(
        url = paste0("https://fonts.google.com/download?family=", x), 
        destfile = paste0("fonts/", x, ".zip"), 
        mode = "wb"
      )
      unzip(zipfile = paste0("fonts/", x, ".zip"), exdir = file.path("fonts", x))
      unlink(paste0("fonts/", x, ".zip"))
    } ## End if download font
    
    ## Import fonts to R sysfonts
    if (!(x %in% names(windowsFonts()))) {
      extrafont::font_import(paths = "fonts", recursive = T, pattern = str_remove(x, " "), prompt = F)
      extrafont::loadfonts(device = "win")
    } ## End if add to R sysfonts
    
  }) ## End walk
  
} ## End if check OS

## Get a font compatible with Thai characters
library(showtext)
font_add("Sarabun", "fonts/Sarabun/Sarabun-Regular.ttf")
font_add("ChakraPetch", "fonts/Chakra Petch/ChakraPetch-Regular.ttf")
showtext_auto()


