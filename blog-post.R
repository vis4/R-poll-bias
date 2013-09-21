
# note: you may need to install the used libraries first
# to do so just run:
#
# install.packages(c('zoo', 'plotrix'))
#
# I used the following margins for the graphs
# par(mar=c(4,2.3,2,0))

library(plotrix)
library(zoo)

source("inc/plot_polls.R")

# load poll data from CSV
polls <- load_polls('polls.csv')

# plot all polls in one graph
plot_polls(polls, "All institutes, all parties")

# plot polls of a single party
# valid keys are: spd, cdu, gru, fdp, lin, pir, afd, rep
plot_polls(polls, party='spd', show_avg=F, main="All polls for SPD")

# include the median plot by omitting the show_avg=F
plot_polls(polls, party='spd', main="All polls for SPD vs. median")

# focus on one polling institute using the inst= parameter
# valid keys are: Emnid, Infratestdimap, Forsa, GMS, Allensbach, INSA, FGW
plot_polls(polls, party='spd', inst='Emnid', main="SPD / TNS Emnid vs. median")
plot_polls(polls, party='spd', inst='Infratestdimap', main="SPD / Infratest dimap vs. median")
plot_polls(polls, party='spd', inst='Forsa', main="SPD / Forsa vs. median")

# generate Tukey's median-difference plot
plot_median_diff(polls, 'spd', 'Forsa', main='SPD / Forsa - Median-difference plot')
# ..and the median bias (= the quarterly median of the median-difference plot)
plot_median_median_diff(polls, 'spd', 'Forsa', main='SPD / Forsa - Median-difference plot')

# more examples, please

plot_polls(polls, party='cdu', inst='FGW', limit=c(2000,2013), main="CDU / Forschungsgruppe Wahlen")
plot_median_median_diff(polls, 'cdu', 'FGW', limit=c(2000,2013), main='CDU / Forschungsgruppe Wahlen - Median-difference plot')

plot_polls(polls, party='lin', inst='FGW', limit=c(2000,2013), main="DIE LINKE / Forschungsgruppe Wahlen")
plot_median_median_diff(polls, 'lin', 'FGW', limit=c(2000,2013), main='DIE LINKE / Forschungsgruppe Wahlen - Median-difference plot')

plot_polls(polls, party='lin', inst='Emnid', limit=c(2000,2013), main="DIE LINKE / Emnid")
plot_median_median_diff(polls, party='lin', inst='Emnid', limit=c(2000,2013), main="DIE LINKE / Emnid - Median-difference plot")

