#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param input
#' @param filepath
#' @return
#' @author Tiernan
#' @export
write_parquet <- function(input, filepath) { 
  
  sfarrow::st_write_parquet(obj = input, dsn = filepath)
  
  return(filepath)

}
