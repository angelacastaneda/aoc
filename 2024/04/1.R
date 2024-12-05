#!/usr/bin/env Rscript

library(stringr)
library(magrittr)

test_input <- "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX"

file_name <- "input.txt"
input <- readChar(file_name, file.info(file_name)$size)

input_rows <- str_split_1(input, "\n")
max_col <- nchar(input_rows[1])

max_row <- length(input_rows)
input_matrix <- matrix(unlist(str_split(input_rows, "")),
                       nrow = max_row, byrow = TRUE)

get_letter <- function(r, c) {
  if (r > max_row || r < 1) {
    return(" ")
  }
  if (c > max_col || c < 1) {
    return(" ")
  }
  return(input_matrix[r, c])
}

# count_xmas takes in a coordinate r and c and returns the count of how many
# words XMAS start from that point.
count_xmas <- function(r, c, word = "XMAS") {
  # constructing the eight different orientations for XMAS
  # eg: ltr <- (0, 1); rtl <- (0, -1); bottom-up <- (-1, 0); etc
  x <- c(-1, 0, 1)
  y <- c(-1, 0, 1)
  combos <- expand.grid(x = x, y = y)
  combos <- combos[!(combos$x == 0 & combos$y == 0), ]

  word_vec <- str_split_1(word, "")

  count <- 0

  for (i in 1:length(combos$x)) {
    r_direction <- combos$x[i]
    c_direction <- combos$y[i]

    for (j in seq_along(word_vec)) {
      r_step <- r + ((j - 1) * r_direction)
      c_step <- c + ((j - 1) * c_direction)
      if (get_letter(r_step, c_step) != word_vec[j]) break

      # if at end of sequence
      if (j == length(word_vec)) count <- count + 1
    }
  }

  return(count)
}

xes <- which(input_matrix == "X", arr.ind = TRUE) %>%
  as.data.frame

xes$xmases <- 0

for (i in 1:nrow(xes)) {
  xes$xmases[i] <- count_xmas(xes$row[i], xes$col[i])
}

sum(xes$xmases)
