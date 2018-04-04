for (package in c('readr')) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package)
    library(package, character.only = T)
  }
}

house_data <-
  read_delim(
    "house_data.csv",
    ";",
    escape_double = FALSE,
    locale = locale(decimal_mark = ","),
    trim_ws = TRUE
  )

house_data2 <- subset(house_data, yr_built %in% c(1990))
