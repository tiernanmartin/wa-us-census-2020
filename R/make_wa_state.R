#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @param year
#' @return
#' @author Tiernan
#' @export
make_wa_state <- function(year = 2020) {

  states_raw <- tigris::states(year = year, cb = TRUE)
  
  states <- states_raw |> 
    tibble::as_tibble() |> 
    sf::st_sf() |>
    janitor::clean_names()
    
  wa <- dplyr::filter(states, stringr::str_detect(name,"Washington")) 
  
  wa_ready <- wa
  
  return(wa_ready)

}
