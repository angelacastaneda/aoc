#!/usr/bin/env Rscript

test <- "3   4
4   3
2   5
1   3
3   9
3   3"

# data <- read.table(text = test)
data <- read.table("input.txt")

first <- data[, 1]
second <- data[, 2]

get_similarity <- function(x) {
  x * sum(second == x)
}

scores <- sapply(first, get_similarity)
sum(scores)
