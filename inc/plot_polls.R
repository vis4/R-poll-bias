library(plotrix)
library(zoo)

source("inc/load_polls.R")
source("inc/add_colors.R")
source("inc/plot_axes.R")
source("inc/get_median.R")
source("inc/quarts.R")
source("inc/plot_median_diff.R")
source("inc/plot_median_median_diff.R")

plot_polls <- function(X, main='', party=F, inst=F, show_avg=T, limit=c(1998, 2013)) {
  if (main == '') main = paste(inst, '-', toupper(party))
  p <- party
  avg <- F
  if (party != F) {
    X <- subset(X, X$party == p)
    if (show_avg) avg <- get_median(X)
  }
  plot_w_context(X, "value", inst, limit=limit, main=main)
  
  if (show_avg == T & p != F) {
    lines(avg$date, avg$value, lwd=5, col='white')
    lines(avg$date, avg$value)
  }
  abline(h=c(5,10,20,30,40,50), lty="dashed", col='#00000033')
  plot_axes(X)
}

plot_w_context <- function(X, value, inst, limit=c(1998, 2013), main='', cex.focus=0.5, cex.context=0.2) {
  context <- F
  i <- inst
  if (i != F) {
    context <- subset(X, X$inst != i)
    X <- subset(X, X$inst == i)
    context$color = '#bbbbbb'
  }
  has_context = i != F
  ylim <- NULL
  xlim <- NULL
  if (has_context) {
    ylim <- c(min(min(X[,value], na.rm=T), min(context[,value], na.rm=T)),
              max(max(X[,value], na.rm=T), max(context[,value], na.rm=T)))
  }
  if (is.vector(limit)) {
    xlim <- as.POSIXct(c(
      paste(limit[1],"/1/1",sep=''),
      paste(limit[2],"/12/31",sep='')
    ))
  }
  plot(X$date, X[,value], col=X$color, axes=F, cex=cex.focus, pch=20, ylab="",
       xlab="", xlim=xlim, ylim=ylim, type=ifelse(has_context, 'n', 'p'), main=main)
  
  if (has_context) {
    points(context$date, context[,value], col=context$color, pch=20, cex=cex.context)
    points(X$date, X[,value], col=X$color, pch=15, cex=cex.focus)
  }
  
  max_y <- ifelse(has_context, ylim[2], max(X$value, na.rm=T))
  plot_elections(max_y)
  
}

plot_elections <- function(ypos=0) {
  elections <- as.POSIXct(c("1998/9/27", "2002/9/22", "2005/9/18", "2009/9/27"))
  boxed.labels(elections, ypos, labels=paste(' Btw', 1900+as.POSIXlt(elections)$year), border=F, cex=0.7, adj=0, col='#00000077')
  abline(v=elections, col='#00000033')
}

