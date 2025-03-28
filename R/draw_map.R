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
  
  lines <- cbind(c(132, 135, 137, 137), c(38, 38, 40, 43)) |> 
    sf::st_linestring()
  
  japan$map_df %>%
    ggplot2::ggplot() +
    ggplot2::geom_sf(ggplot2::aes(fill = vec)) +
    ggplot2::geom_sf(data = lines, color = "gray80") +
    ggplot2::scale_fill_gradient2(
      low = "#559999",
      mid = "grey90",
      high = "#BB650B",
      midpoint = stats::median(vec),
      labels = scales::comma
    ) +
    ggplot2::labs(fill = "yen per year\nper household") +
    ggplot2::coord_sf(xlim = c(130, 149), ylim = c(31, 45)) +
    ggplot2::theme_void()
}
