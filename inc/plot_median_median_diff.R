plot_median_median_diff <- function(X, party, inst, main='', limit=c(1998,2013)) {
  p <- party
  plot_median_diff(X, party, inst, main, cex.focus=0.14, cex.context=0.06, limit=limit)
  d <- get_median_median_diff(X, party, inst)
  lines(d$date, d$diff, lwd=3, col=subset(X, X$party==p)$color[1])
  #lines(d$date, d$diff, lwd=2, col='white')
}


get_median_median_diff <- function(X, p, i) {
  attach(X)
  X$value[party != p] = NA  # ignore other parties
  avg_party <- as.numeric(get_median(X, asList=T))  # compute median
  X$value[X$inst != i] = NA  # ignore other institutes
  avg_party_inst <- as.numeric(get_median(X, asList=T, meanOfMedianPerInstitute=F))
  diff = avg_party_inst - avg_party
  data.frame(diff=diff, date=quarts(1994,4, length(avg_party)))
}
