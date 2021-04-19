draw_col <- function(df) {
  national_average <- df %>%
    filter(area_code == "00000") %>%
    pull(value)
  
  stopifnot(length(national_average) == 1)
  
  df %>%
      filter(area_code != "00000") %>%
      mutate(loser = !near(value, max(value))) %>%
      ggplot(aes(value, fct_rev(city_e), fill = loser)) +
      geom_col(width = 1) +
      geom_vline(xintercept = national_average,
                 color = "white",
                 size = 1) +
      annotate("text",
               y = "26100 Kyoto",
               x = national_average,
               label = "National average") +
      guides(fill = "none") +
      scale_x_continuous(labels = comma) +
      labs(x = "annual expenditure per household (yen)", y = NULL)
}


