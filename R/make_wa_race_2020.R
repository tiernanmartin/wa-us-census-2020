#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title make_wa_race_2020

#' @param pl_raw
#' @param sum_level
#' @return
#' @author Tiernan
#' @export
make_wa_race_2020 <- function(pl_raw, sum_level) {
  
  sum_level_code <- PL94171::pl_geog_levels |> 
    dplyr::filter(SUMLEV_description %in% sum_level) |> 
    pull(SUMLEV) 
    
  race_raw <- pl_raw |> 
    PL94171:: pl_subset(sumlev = sum_level_code) |> 
    PL94171::pl_select_standard()
   
  wa_race_2020 <- race_raw |> 
    transmute(
      geoid = GEOID,
      pop_cnt_total_2020 = pop,
      pop_cnt_hispanic_2020 = pop_hisp,
      pop_pct_hispanic_2020 = purrr::map2_dbl(pop_cnt_hispanic_2020,
                                          pop_cnt_total_2020,
                                          divide_zero
                                     ),
      pop_cnt_white_2020 = pop_white,
      pop_pct_white_2020 = purrr::map2_dbl(pop_cnt_white_2020,
                                              pop_cnt_total_2020,
                                              divide_zero
      ),
      pop_cnt_black_2020 = pop_black,
      pop_pct_black_2020 = purrr::map2_dbl(pop_cnt_black_2020,
                                           pop_cnt_total_2020,
                                           divide_zero
      ),
      pop_cnt_aian_2020 = pop_aian,
      pop_pct_aian_2020 = purrr::map2_dbl(pop_cnt_aian_2020,
                                           pop_cnt_total_2020,
                                           divide_zero
      ),
      pop_cnt_asian_2020 = pop_asian,
      pop_pct_asian_2020 = purrr::map2_dbl(pop_cnt_asian_2020,
                                          pop_cnt_total_2020,
                                          divide_zero
      ),
      pop_cnt_nhpi_2020 = pop_nhpi,
      pop_pct_nhpi_2020 = purrr::map2_dbl(pop_cnt_nhpi_2020,
                                           pop_cnt_total_2020,
                                           divide_zero
      ),
      pop_cnt_other_2020 = pop_other,
      pop_pct_other_2020 = purrr::map2_dbl(pop_cnt_other_2020,
                                          pop_cnt_total_2020,
                                          divide_zero
      ),
      pop_cnt_two_2020 = pop_two,
      pop_pct_two_2020 = purrr::map2_dbl(pop_cnt_two_2020,
                                           pop_cnt_total_2020,
                                           divide_zero
      ),
      pop_cnt_poc_2020 = pop_cnt_total_2020-pop_cnt_white_2020,
      pop_pct_poc_2020 = purrr::map2_dbl(pop_cnt_poc_2020,
                                         pop_cnt_total_2020,
                                         divide_zero
      )
    )
  
  return(wa_race_2020)

}
