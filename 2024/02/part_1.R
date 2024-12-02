#!/usr/bin/env Rscript

library(magrittr)

input <- "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

# con <- textConnection(input, "r")

data <- readLines("input.txt")
# close(con)

is_gradual <- function(x) {
  if (x[1] > 0) {
    return(all(x > 0 & x < 4))
  }
  if (x[1] < 0) {
    return(all(x < 0 & x > -4))
  }
  if (x[1] == 0) {
    return(FALSE)
  }
}

reports <- data %>%
  strsplit(" ") %>%
  lapply(as.integer) %>%
  lapply(diff) %>%
  lapply(is_gradual)

length(reports[reports == TRUE])
