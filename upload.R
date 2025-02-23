library(DBI)
library(RPostgres)
readRenviron(".Renviron")

con <- dbConnect(
    RPostgres::Postgres(),
    dbname = Sys.getenv("DB_NAME"),
    host = Sys.getenv("DB_HOST"),
    port = as.integer(Sys.getenv("DB_PORT")),
    user = Sys.getenv("DB_USER"),
    password = Sys.getenv("DB_PASSWORD")
)

for (file in list.files(path = Sys.getenv("proj_dir"), pattern = "\\.csv$", full.names = TRUE)) {
    df <- read.csv(file)
    table_name <- tools::file_path_sans_ext(basename(file))
    dbWriteTable(con, table_name, df, row.names = FALSE, append = TRUE)
}

dbDisconnect(con)
