# plots all values

polls <- read.csv("flat.csv", sep='\t') # load csv

polls$date <- strptime(as.character(polls$date), "%Y-%m-%d") # convert date column to R date type

source("add_colors.R") # some nice colors
polls = add_colors(polls)


attach(polls)

plot(date, value, col=color, axes=F, cex=0.5, pch=20,ylab="%", xlab="", main="Polls")

# add time axes
abline(h=0)
axis(2, las=2, cex.axis=0.85)
axis.POSIXct(1, las=2, at=seq(min(date), max(date), by="year"), cex=0.85, cex.axis=0.85, format="%Y")


#contr <- subset(contr, contb_receipt_amt<10000)
#contr_dem <- subset(contr, cand_nm == "Obama, Barack")
#contr_dem$color <- "#2255EE66"


#plot(date, value, axes=F, col=color,cex=1,pch=20,ylim=c(-10000,10000),ylab="",xlab="",main="Contributions to Barack Obama in 2011 (without Super PACs)")
#plot(date,contb_receipt_amt,axes=F,col=color,cex=1,pch=20,ylim=c(-10000,10000),ylab="",xlab="",main="Contributions to Barack Obama in 2011 (without Super PACs)")
#abline(h=0)

# add time axes
#axis(2, las=2, cex.axis=0.85)
#axis.POSIXct(1, las=2, at=seq(as.Date("2011/1/1"), as.Date("2012/01/01"), by="month"), cex=0.85, cex.axis=0.85, format="%b")

#detach(contr_dem)