#' Japan Family Income and Expenditure Survey
#'
#' @source https://www.stat.go.jp/english/data/kakei/
#' @format A list.
#' \describe{
#' \item{expense}{
#' @format A tibble.
#' \describe{
#' \item{level}{1}
#' \item{cat01_code}{"001100000"}
#' \item{cat01}{"消費支出"}
#' \item{area_code}{"00000"}
#' \item{city}{"全国"}
#' \item{city_e}{"National"}
#' \item{year}{2007}
#' \item{value}{3573382}
#' \item{ranks}{NA, available only for level 5 and not 全国}
#' }
#' }
#' \item{map_df}{
#' @format A data frame. Each row is prefecture map data. 47 rows.
#' \describe{
#' \item{SP_ID}{"1"}
#' \item{jiscode}{"01"}
#' \item{name}{"Hokkaido"}
#' \item{population}{5506419}
#' \item{region}{"Hokkaido"}
#' \item{geometry}{sf data}
#' }
#' }
#' \item{cat01_code_level}{
#' item menu
#' @format A list.
#' \describe{
#' \item{1}{cat01_code menu list for level 1}
#' \item{2}{cat01_code menu list for level 2}
#' \item{3}{cat01_code menu list for level 3}
#' \item{4}{cat01_code menu list for level 4}
#' \item{5}{cat01_code menu list for level 5}
#' }
#' }
#' \item{city_menu}{
#' @format A named character vector. Length is 52.
#' \describe{
#' \item{01100 札幌市}{"01100 Sapporo"}
#' }
#' }
#' }
"japan"
