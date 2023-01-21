#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @param year
#' @param erase_water
#' @return
#' @author Tiernan
#' @export
make_wa_places <- function(year = 2020, erase_water = FALSE) {

wa_places_raw <- tigris::places(state = 53, 
                                year = year,
                                cb = TRUE)

wa_pl <- wa_places_raw |> 
  tibble::as_tibble() |> 
  sf::st_sf() |> 
  janitor::clean_names()

wa_places_ready <- wa_pl


if(erase_water){
  
  wa_places_ready <- wa_pl |> 
    erase_water_washington(area_threshold = .75)  
  
}

return(wa_places_ready)

}
