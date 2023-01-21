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
make_wa_tracts <- function(year = 2020, erase_water = FALSE) {

  tr_raw <- tigris::tracts(state = 53, year = year, cb = TRUE)
  
  tr_clean <- tr_raw |> 
    janitor::clean_names() |> 
    tibble::as_tibble() |> 
    sf::st_sf()
  
  tr_ready <- tr_clean
  
  if(erase_water){
    tr_ready <- erase_water_washington(tr_clean)
  }
  
  
  return(tr_ready)

}
