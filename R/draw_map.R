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
  exp_only_capital <- df %>%
    dplyr::filter(!area_code %in% c("00000", "14004", "14150", "22004", "27004", "40003")) %>%  #全国、川崎市、相模原市、浜松市、堺市、北九州市
    dplyr::pull(value)
  
  stopifnot(length(exp_only_capital) == 47)  
  
  japan$map_df %>%
    ggplot2::ggplot() +
    ggplot2::geom_sf(ggplot2::aes(fill = exp_only_capital)) +
    ggplot2::scale_fill_gradient2(
      low = "#559999",
      mid = "grey90",
      high = "#BB650B",
      midpoint = stats::median(exp_only_capital)
    ) +
    ggplot2::labs(fill = "yen per year\nper household") +
    ggplot2::theme_void()
}
