#' Draw column chart
#'
#' @param df A data frame.
#'
#' @return A plot.
#'
#' @examples
#' \dontrun{
#' draw_col(data())
#' }
draw_col <- function(df) {
  national_average <- df %>%
    dplyr::filter(area_code == "00000") %>%
    dplyr::pull(value)
  
  stopifnot(length(national_average) == 1)
  
  df %>%
    dplyr::filter(area_code != "00000") %>%
    dplyr::mutate(loser = (value != max(value))) %>%
    ggplot2::ggplot(ggplot2::aes(value, forcats::fct_rev(city_e), fill = loser)) +
    ggplot2::geom_col(width = 1) +
    ggplot2::geom_vline(xintercept = national_average,
                 color = "white",
                 linewidth = 1) +
    ggplot2::annotate("text",
               y = "26100 Kyoto",
               x = national_average,
               label = "National average") +
    ggplot2::guides(fill = "none") +
    ggplot2::scale_x_continuous(labels = scales::comma) +
    ggplot2::labs(x = "annual expenditure per household (yen)", y = NULL)
}
