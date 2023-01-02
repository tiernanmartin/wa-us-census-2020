#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author Tiernan
#' @export
make_wa_tracts_2020 <- function() {

  tr_raw <- tigris::tracts(state = 53, year = 2020, cb = TRUE)
  
  tr_clean <- tr_raw |> 
    janitor::clean_names() |> 
    tibble::as_tibble() |> 
    sf::st_sf()
  
  tr_nowater <- erase_water_washington(tr_clean)
  
  tr_ready <- tr_nowater
  
  return(tr_ready)

}
