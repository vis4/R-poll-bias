

plot_median_diff <- function(X, party, inst, main='', limit=c(1998,2013), cex.focus=0.5, cex.context=0.2) {
  X <- get_median_diff(X, party)
  #plot(X$date, X$median.diff)
  plot_w_context(X, 'median.diff', inst, main=main, limit=limit,
                 cex.focus=cex.focus, cex.context=cex.context)
  abline(h=0)
  plot_axes(X)
}

get_median_diff <- function(X, p, i) {
  attach(X)
  X$value[party != p] = NA
  #_party <- as.numeric(tapply(X$value, as.yearqtr(X$date), median, na.rm=T))
  median_val <- tapply(X$value, as.yearqtr(X$date), median, na.rm=T)
  X$median.diff <- X$value - as.numeric(median_val[as.character(as.yearqtr(X$date))])
  X
}

