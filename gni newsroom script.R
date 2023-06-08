#install.packages("readxl")
library(readxl)
#install.packages("tidyverse")
library(tidyverse)
#install.packages("reshape2")
library(reshape2)
## read data 
setwd("C:\\Users\\mona\\Documents\\GNI Task")
data <- read_excel("C:\\Users\\mona\\Documents\\GNI Task\\vgrdl_r2b3_bs2021_0.xlsx", sheet = "2.4", range = "H5:AH451")

## filtern 
data_kleiner <- subset(data, Gebietseinheit == "Berlin" | Gebietseinheit == "Deutschland")

## reshape 
new_data <- melt(data_kleiner, id.vars = c("Gebietseinheit"), variable.name = "year", value.name = "income")
View

## check format 
sapply(new_data, class)
new_data$income <- as.numeric(new_data$income)

## plot line graph 
ggplot() +
  geom_hline(yintercept = seq(15000, 23000, by = 1000), color = "grey", linewidth = 0.1) +
  geom_line(data = new_data, aes(x = year, y = income, group = Gebietseinheit, color = Gebietseinheit)) +
  scale_color_manual(values=c("#ff13a2", "#ffb313")) + 
  labs(title = "Einkommen in Privathaushalten", 
       subtitle = "So hat sich das Einkommen (in Euro) in Berlin und Deutschland zwischen 1995 und 2020 \n verändert.", 
       caption="Quelle: Statistische Ämter der Länder") +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.title = element_blank(),
        panel.background = element_rect(fill = "white"), 
        plot.title = element_text(face="bold"),
        plot.subtitle = element_text(size=7),
        legend.position=c(0.9,0.3), 
        legend.text = element_text(size=7),
        plot.title.position="plot", 
        plot.caption = element_text(size=6, color="grey"),
        axis.text.y = element_text(size=6,color= "grey"), 
        axis.text.x = element_text(size=6, color = "grey"),
        axis.ticks = element_blank()) +
  scale_x_discrete(breaks=seq(1995,2020, by=5)) + 
  scale_y_continuous(breaks=seq(15000,23000, by=1000))

                

ggsave("linechartfinal.png", width=1240, height=1040, unit = "px")

