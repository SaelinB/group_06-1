"This is a script to process the raw adult_data.csv and save cleaned csv in /data directory

Usage: process_data.R --raw_data=<path_to_raw> --processed=<file_name>" -> doc

suppressPackageStartupMessages(library(tidyverse)) 
suppressPackageStartupMessages(library(glue)) 
suppressPackageStartupMessages(library(docopt)) 

opt <- docopt(doc)

#' cleans raw .csv loaded by load_data.R. In doing so, fixes titles and changes "?" to NAs
#'
#' @param raw_data The path to the raw .csv data
#' @param processed The filename (not including path) to save cleaned .csv as
#' @return cleaned .csv file
#' @examples 
#' function("data/adult_data.csv","adult_data_clean.csv")

main <- function(raw_data, processed) {
  
  raw <- read.csv(raw_data)
  
  #fix the data
  adult_data <-raw %>% rename("age"=X1,"workclass"=X2,"fnlwgt"=X3,"education"=X4,
           "education_num"=X5,"marital_status"=X6,"occupation"=X7,"relationship"=X8,
                                 "race"=X9,"sex"=X10,"capital_gain"=X11,"capital_loss"=X12,"hours_per_week"=X13,
                                 "country"=X14,"income"=X15)  %>%   #give appropriate column names
    
  mutate(income=recode(income, ">50K"="over_50K", "<=50K"="under_50K")) %>%  #re-write in better format
    
    mutate_at(vars("workclass","education","marital_status","occupation","relationship","race","sex","country"), na_if, "?") #change "?" to NAs
  
    adult_data$education_num <-as.factor(adult_data$education_num) #change education level to factor 
  
    write.csv(adult_data, glue('data/', processed))
  
    print(glue("The raw data has been processed and saved as ", processed, " in Milestone_3/data"))  
}

main(opt$raw, opt$processed)
