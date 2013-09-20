
plot_polls <- function(polls) {
  polls = add_colors(polls)
  plot(date, value, col=color, axes=F, cex=0.5, pch=20,ylab="%", xlab="", main="Umfragewerte aller Parteien")
  plot_axes(polls)
}

add_colors <- function(polls) {
  attach(polls)
  polls$color[party == "cdu"] <- "#222222"
  polls$color[party == "spd"] <- "#dd0000"
  polls$color[party == "gru"] <- "#66cc00"
  polls$color[party == "fdp"] <- "#ddcc32"
  polls$color[party == "lin"] <- "#993399"
  polls$color[party == "pir"] <- "#ff9900"
  polls$color[party == "rep"] <- "#772200"
  polls$color[party == "afd"] <- "#009EE0"
  detach(polls)
  polls
}

plot_axes  <- function(X) {
  abline(h=5, lty="dashed")
  abline(h=50, lty="dashed")
  elections <- as.POSIXct(c("1998/9/27", "2002/9/22", "2005/9/18", "2009/9/27"))
  boxed.labels(elections, max(X$value, na.rm=T)+1, labels=paste(' Btw', 1900+as.POSIXlt(elections)$year), border=F, cex=0.7, adj=0)
  abline(v=elections, lty='dotted')
  
  axis(2, las=2, cex.axis=0.85)
  axis(4, las=2, cex.axis=0.85)
  axis.POSIXct(1, las=2, at=seq(as.POSIXlt(paste(1900+min(X$date)$year,'/1/1', sep='')), max(X$date), by="year"), cex=0.85, cex.axis=0.85, format="%Y")
}