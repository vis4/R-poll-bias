source("plot_polls.R")
# plots all values

polls <- load_polls()

attach(polls)

# add time axes

#plot_polls(polls, "Umfragewerte aller Parteien")

plot_polls(polls, main="Allensbach und die FDP",
           inst='Allensbach', party='fdp', show_avg=T)

plot_polls(polls, main="Forsa und die SPD",
           inst='Forsa', party='spd', show_avg=T)
#plot_polls(polls, filter_inst='Forsa', filter_party='spd')

#plot_inst_party(polls, 'Allensbach', 'fdp')