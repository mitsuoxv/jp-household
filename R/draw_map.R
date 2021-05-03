#' Draw Japan prefecture map
#'
#' @param df A data frame.
#'
#' @return A plot.
#'
#' @examples
#' \dontrun{
#' draw_map(data())
#' }
draw_map <- function(df) {
  stopifnot(nrow(df) == 47)  
  
  japan$map_df %>%
    ggplot2::ggplot() +
    ggplot2::geom_sf(ggplot2::aes(fill = df$value)) +
    ggplot2::scale_fill_gradient2(
      low = "#559999",
      mid = "grey90",
      high = "#BB650B",
      midpoint = stats::median(df$value)
    ) +
    ggplot2::labs(fill = "yen per year\nper household") +
    ggplot2::theme_void()
}
