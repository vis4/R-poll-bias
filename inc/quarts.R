quarts <- function(year, Q, len) {
  Q <- Q - 1
  strptime(as.character(sapply(1:len-1, function(i) {
    t = Q + i
    m = (t %% 4)*3 + 2
    y = year + floor(t/4)
    paste(y,m,15, sep='-')
  })), "%Y-%m-%d")
}
