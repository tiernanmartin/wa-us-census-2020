#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @param filepath
#' @return
#' @author Tiernan
#' @export
make_wa_places_2010 <- function(filepath) {

  # source: 
  # https://www2.census.gov/geo/tiger/TIGER2010/PLACE/2010/tl_2010_53_place10.zip
  
  wa_places_raw <- sf::st_read(filepath)
  
  wa_pl <- wa_places_raw |> 
    tibble::as_tibble() |> 
    sf::st_sf() |> 
    janitor::clean_names()
  
  wa_pl_nowater <- wa_pl |> 
    erase_water_washington(area_threshold = .75)
  
  wa_places_ready <- wa_pl_nowater

return(wa_places_ready)

}
