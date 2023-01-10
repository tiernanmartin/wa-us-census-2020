#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' 
#' @param year
#' @return
#' @author Tiernan
#' @export
make_wa_counties <- function(year = 2020) {

  county_raw <- tigris::counties(state = 53, year = year, cb = TRUE)
  
  county_clean <- county_raw |> 
    janitor::clean_names() |> 
    tibble::as_tibble() |> 
    sf::st_sf()
  
  county_nowater <- erase_water_washington(county_clean)
  
  county_ready <- county_nowater
  
  return(county_ready)

}
