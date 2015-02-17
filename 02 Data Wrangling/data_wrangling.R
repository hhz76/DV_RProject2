require("dplyr")
require("ggplot2")
require("reshape2")
require("tidyr")

earthquakes %>% group_by(LONGITUDE) %>% summarize(avg_mag = mean(MAG)) %>% ggplot(aes(x = LONGITUDE, y = avg_mag)) + geom_density2d()
earthquakes %>% group_by(NST) %>% summarise(ave_mag=mean(MAG)) %>% ggplot(aes(x=NST, y=ave_mag)) + geom_point()

eq_date_group <- earthquakes %>% mutate(date = substr(TIME,1,10)) %>% group_by(date) %>% summarize(avg_depth=mean(DEPTH),avg_mag=mean(MAG),num_eqs = n()) %>% arrange(date)

mdf <- melt(eq_date_group, id.vars="date", measure.vars = c("avg_depth","avg_mag"))

ggplot(mdf, aes(x=date,y=value,group=variable))+geom_line(aes(color=variable))