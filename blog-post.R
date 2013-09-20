
source("inc/plot_polls.R")

polls <- load_polls('polls.csv')

plot_polls(polls, "All institutes, all parties")

plot_polls(polls, party='spd', show_avg=F, main="All polls for SPD")
plot_polls(polls, party='spd', main="All polls for SPD vs. median")

plot_polls(polls, party='spd', inst='Emnid', main="SPD / TNS Emnid vs. median")
plot_polls(polls, party='spd', inst='Infratestdimap', main="SPD / Infratest dimap vs. median")
plot_polls(polls, party='spd', inst='Forsa', main="SPD / Forsa vs. median")

plot_median_diff(polls, 'spd', 'Forsa', main='SPD / Forsa - Median-difference plot')
plot_median_median_diff(polls, 'spd', 'Forsa', main='SPD / Forsa - Median-difference plot')

# more examples, please

plot_polls(polls, party='cdu', inst='FGW', limit=c(2000,2013), main="CDU / Forschungsgruppe Wahlen")
plot_median_median_diff(polls, 'cdu', 'FGW', limit=c(2000,2013), main='CDU / Forschungsgruppe Wahlen - Median-difference plot')

plot_polls(polls, party='lin', inst='FGW', limit=c(2000,2013), main="DIE LINKE / Forschungsgruppe Wahlen")
plot_median_median_diff(polls, 'lin', 'FGW', limit=c(2000,2013), main='DIE LINKE / Forschungsgruppe Wahlen - Median-difference plot')

plot_polls(polls, party='lin', inst='Emnid', limit=c(2000,2013), main="DIE LINKE / Emnid")
plot_median_median_diff(polls, party='lin', inst='Emnid', limit=c(2000,2013), main="DIE LINKE / Emnid - Median-difference plot")
