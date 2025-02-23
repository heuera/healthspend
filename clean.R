library(tidyverse)
readRenviron(".Renviron")

data_dir <- "~/Downloads/residence state estimates" 

clean_data <- function(file){
    temp <- read.csv(file)
    temp <- temp |> 
        pivot_longer(
            cols = starts_with("Y"),
            names_to = "Year",
            values_to = "Value"
            ) |> 
        mutate(Year = str_remove(Year, "Y"))
    write_csv(temp, file.path(readRenviron(".Renviron"), "clean_data", tolower(basename(file))))
}

for (f in list.files(data_dir, pattern = ".CSV", full.names = TRUE)){
    clean_data(f)
}
