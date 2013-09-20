get_median <- function(X) {
  val <- as.numeric(tapply(X$value, as.yearqtr(X$date), median))
  data.frame(value=val, date=quarts(1994,4,length(val)))
}
