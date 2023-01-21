#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' 
#' @param year
#' @param erase_water
#' @return
#' @author Tiernan
#' @export
make_wa_counties <- function(year = 2020, erase_water = FALSE) {

  county_raw <- tigris::counties(state = 53, year = year, cb = TRUE)
  
  county_clean <- county_raw |> 
    janitor::clean_names() |> 
    tibble::as_tibble() |> 
    sf::st_sf()
  
  county_ready <- county_clean
  
  if(erase_water){
    county_ready <- erase_water_washington(county_clean)
  }
  
  return(county_ready)

}
