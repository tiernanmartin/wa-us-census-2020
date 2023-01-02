divide_zero <- function(x,y){
  if(x==0){
    return(0)
  }
  if(x>0){
    res <- x/y
    return(res)
  }
  stop("An error occurred.")
}


erase_water_washington <- function(x, area_threshold = .90){
  x_wsg84 <- sf::st_transform(x, 32148) # WSG 84 Washington State Plane
  
  res <- x_wsg84 |>  
    tigris::erase_water(year = 2020,
                             area_threshold = area_threshold) |> 
    sf::st_collection_extract("POLYGON") |> 
    dplyr::filter(!sf::st_is_empty(geometry)) |> 
    sf::st_transform(4326)
  
  return(res)
}
