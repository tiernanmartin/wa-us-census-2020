
# SETUP -------------------------------------------------------------------

library(targets)
library(tarchetypes)

# source("./packages.R")

pkgs <- c("conflicted",
          "dotenv",
          "targets",
          "tarchetypes",
          "tidyverse",
          "tidycensus",
          "sf",
          "janitor",
          "mapview",
          "qs",
          "quarto",
          "tigris",
          "sfarrow",
          "glue",
          "mapview",
          "PL94171"
)

tar_option_set(packages = pkgs,
               format = "qs")

lapply(list.files("./R", full.names = TRUE), source)

# load the packages
invisible(sapply(pkgs, library, character.only = TRUE))


# TARGET PIPELINE ---------------------------------------------------------


target_pipeline <- list(
  
  ## DATA TARGETS ------------------------------------------------------------
  tar_target(name = wa_state_2020,
             command = make_wa_state_2020()),
  tar_target(name = wa_counties_2020,
             command = make_wa_counties_2020()),
  tar_target(name = wa_places_2020,
             command = make_wa_places_2020()),
  tar_target(name = wa_tracts_2020,
             command = make_wa_tracts_2020()),
  
  tar_target(name = wa_pl_file,
             command = "data/inputs/wa2020.pl/",
             format = "file"),
  tar_target(name = wa_pl_raw,
             make_wa_pl_raw(filepath = wa_pl_file)),
  tar_target(name = wa_race_state_2020,
             command = make_wa_race_2020(pl_raw = wa_pl_raw,
                                         sum_level = "State")),
  tar_target(name = wa_race_counties_2020,
             command = make_wa_race_2020(pl_raw = wa_pl_raw,
                                         sum_level = "State-County")),
  tar_target(name = wa_race_tracts_2020,
             command = make_wa_race_2020(pl_raw = wa_pl_raw,
                                         sum_level = "State-County-Census Tract")),
  tar_target(name = wa_race_places_2020,
             command = make_wa_race_2020(pl_raw = wa_pl_raw,
                                         sum_level = "State-Place")),
  
  tar_target(name = wa_state_all,
             command = combine_data_by_geog(sf = wa_state_2020,
                                            wa_race_state_2020)),
  tar_target(name = wa_counties_all,
             command = combine_data_by_geog(sf = wa_counties_2020,
                                            wa_race_counties_2020)),
  tar_target(name = wa_tracts_all,
             command = combine_data_by_geog(sf = wa_tracts_2020,
                                            wa_race_tracts_2020)),
  tar_target(name = wa_places_all,
             command = combine_data_by_geog(sf = wa_places_2020,
                                            wa_race_places_2020)),
  
  
  ## OUTPUT TARGETS ----------------------------------------------------------
  
  tar_target(name = output_pqt_wa_state,
             command = write_parquet(
               input = wa_state_all, 
               filepath = "data/outputs/wa-state-census-2020.parquet"),
             format = "file"
  ),
  tar_target(name = output_pqt_wa_counties,
             command = write_parquet(
               input = wa_counties_all, 
               filepath = "data/outputs/wa-counties-census-2020.parquet"),
             format = "file"
  ),
  tar_target(name = output_pqt_wa_tracts,
             command = write_parquet(
               input = wa_tracts_all, 
               filepath = "data/outputs/wa-tracts-census-2020.parquet"),
             format = "file"
  ),
  tar_target(name = output_pqt_wa_places,
             command = write_parquet(
               input = wa_places_all, 
               filepath = "data/outputs/wa-places-census-2020.parquet"),
             format = "file"
  ),
  
  ## REPORT TARGETS ----------------------------------------------------------
  NULL
  # tar_quarto(
  #   report,
  #   path = "report.qmd",
  #   execute_params = list(wa_places_race_2020 = wa_places_race_2020),
  #   cue = tar_cue(mode = "never") # Report will not be updated unless this cue is changed to 'always'
  # )
  
)

## FINAL PIPELINE ----------------------------------------------------------

target_pipeline 