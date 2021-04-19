draw_map <- function(map_df, df) {
  exp_only_capital <- df %>%
    filter(!area_code %in% c("00000", "14004", "14150", "22004", "27004", "40003")) %>%  #全国、川崎市、相模原市、浜松市、堺市、北九州市
    pull(value)
  
  stopifnot(length(exp_only_capital) == 47)  
  
  map_df %>%
    ggplot() +
    geom_sf(aes(fill = exp_only_capital)) +
    scale_fill_gradient2(
      low = "#559999",
      mid = "grey90",
      high = "#BB650B",
      midpoint = median(exp_only_capital)
    ) +
    labs(fill = "yen per year\nper household") +
    theme_void()
}