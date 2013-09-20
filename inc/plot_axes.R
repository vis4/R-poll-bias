plot_axes <- function(X, ticks=NULL) {
  axis(2, at=ticks, las=2, cex.axis=0.75)
  #axis(4, at=ticks, las=2, cex.axis=0.75)
  delta <- as.numeric(max(X$date) - min(X$date), unit="days")
  if (delta > 1000) {
    by <- "year"
    fmt <- "%Y"
  } else {
    by <- "month"
    fmt <- "%Y-%b"
  } 
  date_ticks = seq(
    as.POSIXlt(paste(1900+as.POSIXlt(min(X$date))$year,'/1/1', sep='')),
    max(X$date), by=by)
  
  axis.POSIXct(1, las=2, at=date_ticks, cex.axis=0.75, format=fmt)
}
