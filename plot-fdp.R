# plots all values

polls <- read.csv("flat.csv", sep='\t') # load csv

polls$date <- strptime(as.character(polls$date), "%Y-%m-%d") # convert date column to R date type

source("add_colors.R") # some nice colors
polls = add_colors(polls)

fdp_polls = subset(polls, polls$party == "fdp")

attach(fdp_polls)

plot(date, value, col=color, axes=F, cex=0.5, pch=20,ylab="%", xlab="", main="Umfragewerte der FDP")

# add time axes
abline(h=5, lty="dashed")
axis(2, las=2, cex.axis=0.85)
axis.POSIXct(1, las=2, at=seq(min(date), max(date), by="year"), cex=0.85, cex.axis=0.85, format="%Y")

