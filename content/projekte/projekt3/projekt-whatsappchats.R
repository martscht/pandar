knitr::opts_chunk$set(echo = TRUE)

## install.packages('rwhatsapp')
## library(rwhatsapp)
## raw <- rwa_read('MeineGruppe.txt')

## install.packages('udpipe')
## library(udpipe)
## model <- udpipe_download_model(language = "german")
## udpipe_german <-udpipe_load_model(file = dir(pattern = 'udpipe'))
## 

## setwd('...')
## install.packages('rwhatsapp')
library(rwhatsapp)
whatsapp <- rwa_read('MeineGruppe.txt')

head(whatsapp)

linebreaks <- which(is.na(whatsapp$time) & is.na(whatsapp$author))
for (i in linebreaks) whatsapp[i, 1:2] <- whatsapp[i - 1, 1:2] 

whatsapp <- whatsapp[!is.na(whatsapp$author),]

whatsapp$text[grep('<Medien ausgeschlossen', whatsapp$text)] <- NA

library('ggplot2')

tab <- table(whatsapp$author)
tab

pie(tab, col = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") )

ggplot(whatsapp, aes(x = author)) +
geom_bar(width = 1 , aes(fill = author))

hist(whatsapp$time, breaks = 20, freq = TRUE)
ggplot(whatsapp, aes(x = whatsapp$time))+ geom_histogram()

whatsapp$Wochentage <- weekdays(whatsapp$time)
whatsapp$Wochentage <- factor(whatsapp$Wochentage, levels = c('Montag','Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'))

ggplot(whatsapp, aes(x = Wochentage)) + geom_bar()

whatsapp$uhrzeit <- strftime(whatsapp$time, format = '%H:%M')
whatsapp$uhrzeit <- as.POSIXct(whatsapp$uhrzeit, format = '%H:%M')
ggplot(whatsapp, aes(x = whatsapp$uhrzeit))+ geom_histogram(bins = 10, color = 'white') +
  xlab('Zeit')+ ylab('Nachrichten') + geom_freqpoly(bins = 10) + scale_x_datetime(date_labels = '%H:%M')

whatsapp_new <- whatsapp

whatsapp_new$response <- NA
whatsapp_new$response <-c(whatsapp_new$time[2:nrow(whatsapp_new)], NA)

whatsapp_new$antwortzeit <- whatsapp_new$response - whatsapp_new$time

whatsapp_new$antworter <- NA
whatsapp_new$antworter <-c(as.character(whatsapp_new$author[2:nrow(whatsapp_new)]), NA)
whatsapp_new$antworter <- as.factor(whatsapp_new$antworter)

gleich <- which(whatsapp_new$antworter == whatsapp_new$author)
for (i in gleich) {
  whatsapp_new[i,]$antwortzeit <- NA
  whatsapp_new[i,]$antworter <- NA
  }

zeit <- tapply(whatsapp_new$antwortzeit, whatsapp_new$antworter, median)

tab <- data.frame(levels(whatsapp$author), zeit)
tab$Punkte <- rank(tab$zeit)

tab

## for (i in levels(whatsapp$who)) {
##   chat$what[chat$who == i] <- paste(whatsapp$text[whatsapp$who == i], collapse = ' ')
## }

# install.packages("udpipe")
library(udpipe)

## model <- udpipe_download_model(language = 'german')
germodel <- udpipe_load_model(file = dir(pattern = 'udpipe')) 

emo <- read.csv('EmotionLookupTable.txt', sep = '\t', header = FALSE, stringsAsFactors = FALSE)
names(emo) <- c('Wort', 'Senti', 'Englisch', 'Quelle', 'Entstehung')


boost <- read.table('BoosterWordList.txt', stringsAsFactors = FALSE)
names(boost) <- c('Wort', 'Boost')


negate <- read.table('NegatingWordList.txt', stringsAsFactors = FALSE)
negate <- negate[, 1]

polar <- data.frame(term = emo$Wort, polarity = emo$Senti, stringsAsFactors = FALSE)

ampli <- boost[boost$Boost > 0, 'Wort']
deamp <- boost[boost$Boost < 0, 'Wort']

hans <- whatsapp$text[grep('Hans', whatsapp$author)]
hans <- paste(hans, collapse = ' ')

hans <- udpipe(hans, germodel) 

senti_hans <- txt_sentiment(hans,
  polarity_terms = polar,
  polarity_negators = negate,
  polarity_amplifiers = ampli,
  polarity_deamplifiers = deamp) 

senti_hans$overall 

chat <- data.frame(author = levels(whatsapp$author), what = '', stringsAsFactors = FALSE)
for (i in levels(whatsapp$author)) {
  chat$what[chat$author == i] <- paste(whatsapp$text[whatsapp$author == i], collapse = ' ')
}

chat <- udpipe(chat$what, germodel)

senti_all <- txt_sentiment(chat,
  polarity_terms = polar,
  polarity_negators = negate,
  polarity_amplifiers = ampli,
  polarity_deamplifiers = deamp)
senti_all$overall

senti <- senti_all$overall
senti$doc_id <- levels(whatsapp$author)

senti[order(senti$sentiment_polarity, decreasing = TRUE), ]

tab$senti <- senti$sentiment_polarity
tab$Punkte2 <- rank(-senti$sentiment_polarity)

tab$final <- tab$Punkte + tab$Punkte2
tab$levels.whatsapp.author.[which.min(tab$final)]

tab
