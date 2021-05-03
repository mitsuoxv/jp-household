#' Draw Japan prefecture map
#'
#' @param vec A numeric vector of length 47 in order of jiscode.
#'
#' @return A plot.
#'
#' @examples
#' \dontrun{
#' draw_map(data())
#' }
draw_map <- function(vec) {
  stopifnot(length(vec) == 47)  
  
  japan$map_df %>%
    ggplot2::ggplot() +
    ggplot2::geom_sf(ggplot2::aes(fill = vec)) +
    ggplot2::scale_fill_gradient2(
      low = "#559999",
      mid = "grey90",
      high = "#BB650B",
      midpoint = stats::median(vec),
      labels = scales::comma
    ) +
    ggplot2::labs(fill = "yen per year\nper household") +
    ggplot2::theme_void()
}
