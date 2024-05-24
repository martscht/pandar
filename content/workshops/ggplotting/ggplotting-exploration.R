knitr::opts_chunk$set(echo = TRUE)
library(knitr)
library(devtools)
library(tabplot)

load(url('https://pandar.netlify.app/daten/edu_exp.rda'))
library(ggplot2)

edu_exp |>
  subset(Year == 2016) |>
  ggplot(aes(x=Income, y=Expectancy)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5)) +
  facet_grid(. ~ Region)

library(datasauRus)
names(datasaurus_dozen)

ggplot(datasaurus_dozen, aes(x=x, y=y)) +
  geom_point()

ggplot(datasaurus_dozen, aes(x=x, y=y)) +
  geom_point() +
  facet_wrap(~dataset) +
  labs(x="", y="")

ggplot(datasaurus_dozen, aes(x=x, y=y)) +
  geom_point(aes(colour=dataset), show.legend=F) +
  facet_wrap(~dataset) +
  labs(x="", y="")

quadrieren <- function(zahl){
  ergebnis <- zahl^2
  return(ergebnis)
}

quadrieren(1)
quadrieren(2)
quadrieren(3)

zahlen <- 4:6
for(z in zahlen){
  print(z^2)
}

dipfblau <- rgb(102,153,204, max=255)
tmp.data <- subset(edu_exp, Country == "Afghanistan")
tmp.mw   <- mean(tmp.data$Expectancy)

ggplot(tmp.data, aes(x=Year, y=Expectancy)) +
  geom_line(size=2, show.legend=F) +
  geom_point(size=2.5, show.legend=F) +
  xlim(1997, 2017) +
  ylim(20, 85) +
  labs(x="Jahr", y="Lebenserwartung") +
  ggtitle("Lebenserwartung in Afghanistan im Zeitverlauf", "Kontinent: Europa") +
  geom_hline(aes(yintercept=tmp.mw), size=2, col=dipfblau) +
  annotate("text", 2000, tmp.mw+3, fontface='italic',
           label=paste0("M = ", round(tmp.mw, 2)), col=dipfblau)

gm.plot <- function(which.country, show.mean=FALSE){

  dipfblau <- rgb(102,153,204, max=255)
  tmp.data <- subset(edu_exp, Country == which.country)
  tmp.mw   <- mean(tmp.data$Expectancy)
  
  tmp.plot <- ggplot(tmp.data, aes(x=Year, y=Expectancy)) +
    geom_line(size=2, show.legend=F) +
    geom_point(size=2.5, show.legend=F) +
    xlim(1997, 2017) +
    ylim(20, 85) +
    labs(x="Jahr", y="Lebenserwartung", 
         title=paste0("Lebenserwartung in ", which.country, " im Zeitverlauf"),
         subtitle=paste0("Kontinent: ", tmp.data$Region[1]))

  if(show.mean==TRUE){
    tmp.plot <- tmp.plot +
      geom_hline(aes(yintercept=tmp.mw), size=2, col=dipfblau) +
      annotate("text", 2000, tmp.mw+3, fontface='italic',
               label=paste0("M = ", round(tmp.mw, 2)), col=dipfblau)
  }
  return(tmp.plot)
}

gm.plot("Afghanistan", TRUE)

## dir.create("./gapminder-Plots")

countries <- unique(edu_exp$Country)
head(countries)
length(countries)

## for(c in 1:length(countries)){
##   gm.plot(countries[c], show.mean = TRUE)
##   ggsave(paste0("./gapminder-Plots/Plot-", countries[c], ".png"),
##                 width=24, height=12, units="cm", dpi=200)
##   print(paste0("Grafik erstellt fuer: ", countries[c], " (", c, "/", length(countries), ")"))
## }

edu_exp_sel <- edu_exp[, c("Income", "Expectancy", "Index", "Region")]

library(GGally)
ggpairs(edu_exp_sel, columns = 1:3)

ggpairs(edu_exp_sel, columns = 1:3, aes(color = Region, alpha = .5))

## library(devtools)
## install_github("mtennekes/tabplot")
## library(tabplot)

edu_exp_2 <- subset(edu_exp, select = c("Country", "Region", "Index", "Expectancy", "Population", "Income"))

tableplot(edu_exp_2)

# Sortiert nach Income
tableplot(edu_exp_2,
          select=c(Region, Index, Expectancy, Income), 
          sortCol = Income)
