#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param filepath
#' @return
#' @author Tiernan
#' @export
make_wa_pl_raw <- function(filepath) {

  pl_raw <- PL94171::pl_read(filepath)
  
  return(pl_raw)

}
