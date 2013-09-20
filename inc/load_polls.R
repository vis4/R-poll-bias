load_polls <- function(file, sep='\t') {
  polls <- read.csv(file, sep=sep)
  polls$date <- strptime(as.character(polls$date), "%Y-%m-%d")
  add_colors(polls)
}
