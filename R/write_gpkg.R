#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param input
#' @param filepath
#' @param layer
#' @return
#' @author Tiernan
#' @export
write_gpkg <- function(input, filepath, layer) {

  sf::st_write(input, 
               filepath, 
               driver = "GPKG",
               layer = layer,
               layer_options = "OVERWRITE=true",
               delete_layer = TRUE)
  
  return(filepath)

}
