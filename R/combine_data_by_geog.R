#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param sf
#' @param ...
#' @return
#' @author Tiernan
#' @export
combine_data_by_geog <- function(sf, ...) {

  args <- list(...)  
  
  data_by_geog <- sf |>
    list() |> 
    append(args) |> 
    reduce(left_join, by = "geoid") |> 
    relocate(geometry, .after = last_col())
  
  return(data_by_geog)

}

