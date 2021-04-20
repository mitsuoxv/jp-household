#' Japan Family Income and Expenditure Survey
#'
#' @source https://www.stat.go.jp/english/data/kakei/
#' @format A list.
#' \describe{
#' \item{expense}{
#' @format A tibble.
#' \describe{
#' \item{tab_code}{"01"}
#' \item{表章項目}{"金額"}
#' \item{cat01_code}{"001100000"}
#' \item{cat01}{"消費"}
#' \item{cat02_code}{"03"}
#' \item{世帯区分（年次）}{"二人以上の世帯"}
#' \item{area_code}{"00000"}
#' \item{city}{"全国"}
#' \item{time_code}{"20070000"}
#' \item{時間軸（年次）}{"2007年"}
#' \item{unit}{"円"}
#' \item{value}{3573382}
#' \item{annotation}{NA_character_}
#' \item{level}{1}
#' \item{year}{2007}
#' \item{city_e}{"National"}
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
#' \item{expense}{
#' @format A tibble.
#' \describe{
#' \item{tab_code}{"01"}
#' \item{表章項目}{"金額"}
#' \item{cat01_code}{"010120010"}
#' \item{cat01}{"120"}
#' \item{cat02_code}{"03"}
#' \item{世帯区分（年次）}{"二人以上の世帯"}
#' \item{area_code}{"01003"}
#' \item{city}{"0110"}
#' \item{time_code}{"20070000"}
#' \item{時間軸（年次）}{"2007年"}
#' \item{unit}{"円"}
#' \item{value}{6647}
#' \item{annotation}{NA_character_}
#' \item{level}{5}
#' \item{year}{2007}
#' \item{city_e}{"01100 Sapporo"}
#' \item{ranks}{43}
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
#' \item{city_list}{
#' city menu
#' @format A named list. Length is 52.
#' \describe{
#' \item{01100 札幌市}{"01100 Sapporo"}
#' }
#' }
#' }
"japan"
