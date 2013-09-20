library(plotrix)
library(zoo)

plot_party <- function(X, key, main='') {
  if (main == '') main = paste('Umfragewerte von Partei',key)
  X2 <- subset(X, X$party == key)
  plot_polls(X2, main)
}

plot_inst <- function(X, key, main='', context=F) {
  if (main == '') main = paste('Umfragewerte von Institut',key)
  if (context == T) {
    context <- subset(X, X$inst != key)
  }
  X <- subset(X, X$inst == key)
  plot_polls(X, main, context=context)
}

quarts <- function(year, Q, len) {
  Q <- Q - 1
  as.POSIXlt(sapply(1:len-1, function(i) {
    t = Q + i
    m = (t %% 4)*3 + 2
    y = year + floor(t/4)
    paste(y,m,15, sep='/')
  }))
}

get_avg <- function(X) {
  val <- as.numeric(tapply(X$value, as.yearqtr(X$date), median))
  dates <- as.vector(quarts(1994,4,length(val)))
  data.frame(date=dates, value=val)
}

get_avg_diff <- function(X, p, i) {
  attach(X)
  X$value[party != p] = NA
  avg_party <- as.numeric(tapply(X$value, as.yearqtr(X$date), median, na.rm=T))
  X$value[inst != i] = NA
  avg_party_inst <- as.numeric(tapply(X$value, as.yearqtr(X$date), median, na.rm=T))
  diff = avg_party_inst - avg_party
  dates <- as.vector(quarts(1994,4, length(avg_party)))
  data.frame(date=dates, diff=diff)
}

plot_avg_diff <- function(X, party, inst, main='') {
  d <- get_avg_diff(X, party, inst)
  plot(d$date, d$value, axes=F, cex=0.8, pch=20, ylab="difference from median (%)", xlab="", type='b', main=main)
  
}

plot_polls <- function(X, main='', filter_party=F, filter_inst=F, show_avg=F) {
  context <- F
  avg <- F
  if (filter_party != F) {
    X <- subset(X, X$party == filter_party)
    avg <- get_avg(X)
  }
  if (filter_inst != F) {
    context <- subset(X, X$inst != filter_inst)
    X <- subset(X, X$inst == filter_inst)
    if (filter_party != F) {
      X$color = '#555555'
    }
  }
  X <- subset(X, !is.na(X$value))
  has_context = is.data.frame(context)
  plot(X$date, X$value,
       col=X$color,
       axes=F,
       cex=0.5,
       pch=20,
       ylab="%",
       xlab="",
       type=ifelse(has_context, 'n', 'p'),
       main=main)
  if (has_context) {
    points(context$date, context$value,
           col=context$color,
           pch=20,
           cex=0.2)
    points(X$date, X$value,
           col=X$color,
           pch=15,
           cex=0.5)
  }
  if (show_avg == T) {
    lines(avg$date, avg$value, lwd=5, col='white')
    lines(avg$date, avg$value)
  }
  abline(h=5, lty="dashed")
  abline(h=50, lty="dashed")
  elections <- as.POSIXct(c("1998/9/27", "2002/9/22", "2005/9/18", "2009/9/27"))
  boxed.labels(elections, max(X$value, na.rm=T), labels=paste(' Btw', 1900+as.POSIXlt(elections)$year), border=F, cex=0.7, adj=0)
  abline(v=elections, lty='dotted')
  
  axis(2, las=2, cex.axis=0.85)
  axis(4, las=2, cex.axis=0.85)
  delta <- as.numeric(max(X$date) - min(X$date), unit="days")
  if (delta > 1000) {
    by <- "year"
    fmt <- "%Y"
  } else {
    by <- "month"
    fmt <- "%Y-%b"
  } 
  axis.POSIXct(1, las=2, at=seq(as.POSIXlt(paste(1900+min(X$date)$year,'/1/1', sep='')), max(X$date), by=by), cex=0.85, cex.axis=0.85, format=fmt)
}

add_colors <- function(polls) {
  attach(polls)
  polls$color[party == "cdu"] <- "#222222"
  polls$color[party == "spd"] <- "#dd0000"
  polls$color[party == "gru"] <- "#66cc00"
  polls$color[party == "fdp"] <- "#ccbb22"
  polls$color[party == "lin"] <- "#993399"
  polls$color[party == "pir"] <- "#ff9900"
  polls$color[party == "rep"] <- "#772200"
  polls$color[party == "afd"] <- "#009EE0"
  detach(polls)
  polls
}


load_polls <- function() {
  polls <- read.csv("flat.csv", sep='\t')
  polls$date <- strptime(as.character(polls$date), "%Y-%m-%d")
  add_colors(polls)
}