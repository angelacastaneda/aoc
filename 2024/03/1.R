#!/usr/bin/env Rscript

library(stringr)
library(magrittr)

test <-
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

file_name <- "input.txt"
input <- readChar(file_name, file.info(file_name)$size)

mul <- function(x, y) {
  x * y
}

matches <- str_extract_all(input, "mul\\([0-9]+,[0-9]+\\)")

sapply(matches[[1]], function(x) eval(parse(text = x))) %>%
  sum
