

library(extrafont)
library(showtext)

extrafont::font_import(paths = "fonts", recursive = T, prompt = F)
extrafont::loadfonts(device = "win")

font_add("Sarabun", "fonts/Sarabun/Sarabun-Regular.ttf")
font_add("ChakraPetch", "fonts/Chakra Petch/ChakraPetch-Regular.ttf")
showtext::showtext_auto()