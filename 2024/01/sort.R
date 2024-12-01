#!/usr/bin/env Rscript

test <- "3   4
4   3
2   5
1   3
3   9
3   3"

# data <- read.table(text = test)
data <- read.table("input.txt")

first <- data[, 1] |> sort()
second <- data[, 2] |> sort()

diff <- abs(first - second)
diff |>
  sum() |>
  print()
