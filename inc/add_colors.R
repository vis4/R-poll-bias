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