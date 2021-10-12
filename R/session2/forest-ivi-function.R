
## Create a function to calculate IVI

##
## Demo functions ###########################################################
##

my_sum <- function(.x, .y) {
  .x + .y
}

my_sum(.x = 10, .y = 20)

my_weird_sum <- function(.x , .y) {
  a <- .x + 20
  b <- .y * 2
  a + b
}

my_weird_sum(1, 1)

##
## IVI function #############################################################
##

calc_ivi <- function(.data, .plot_area, .num_species = 20){
  
  total_area <- length(unique(.data$plotID)) * .plot_area
  
  ivi_freq <- .data %>% 
    select(ScName, plotID) %>%
    distinct() %>%
    group_by(ScName) %>%
    summarise(frequency = n() * .plot_area / total_area) %>%
    arrange(desc(frequency))
  
  ivi_dom <- .data %>%
    group_by(ScName) %>%
    summarise(dominance = sum(ba_tree * scale_factor) / total_area) %>%
    arrange(desc(dominance))
  
  ivi_dens <- .data %>%
    group_by(ScName) %>%
    summarise(density = sum(scale_factor) / total_area) %>%
    arrange(desc(density))
  
  ivi_freq %>%
    left_join(ivi_dom, by = "ScName") %>%
    left_join(ivi_dens, by = "ScName") %>%
    mutate(
      relative_freq = frequency / sum(ivi_freq$frequency) * 100,
      relative_dom  = dominance / sum(ivi_dom$dominance) * 100,
      relative_dens = density / sum(ivi_dens$density) * 100,
      IVI           = relative_freq + relative_dom + relative_dens
    ) %>%
    arrange(desc(IVI)) %>%
    filter(ScName != "Unknown") %>%
    slice_head(n = .num_species)
  
} ## End of calc_ivi()



##
## Test function ############################################################
##

calc_ivi(.data = tree, .plot_area = 0.1, .num_species = 5)























