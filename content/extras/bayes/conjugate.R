library(ggplot2)
source('ggplotting-theme-source.R')
theme_set(theme_pandar())

# Beobachtungen
obs <- c(0, 1, 1, 0, 1, 1, 1, 0, 1, 1)

# N
length(obs)

# Erfolgsquote
mean(obs)

sum(obs)

pi <- seq(0, 1, .1)
likelihood <- choose(10, 7) * pi^7 * (1 - pi)^(10 - 7)
d <- data.frame(pi, likelihood)
d

dbinom(7, 10, .2)

likeli_plot <- ggplot(d, aes(x = pi, y = likelihood)) + 
  xlim(0, 1) +
  geom_function(fun = dbinom, args = list(x = 7, size = 10)) +
  labs(x = expression(pi), y = 'Likelihood')
likeli_plot

x <- seq(0, 1, .001)
a <- c(1, 3, 10)
b <- c(1, 5)

dats <- expand.grid(x, a, b)
names(dats) <- c('pi', 'alpha', 'beta')
dats <- dats[dats$alpha == 1 | (dats$alpha != dats$beta), ]

dats$density <- dbeta(dats$pi, dats$alpha, dats$beta)
dats$Parameter <- paste0('\u03B1 = ', dats$alpha, ', \u03B2 = ', dats$beta) |> as.factor()

ggplot(dats, aes(x = pi, y = density, color = Parameter)) + 
  geom_line(lwd = 1.25) + labs(x = '\u03C0', y = 'Dichte') +
  scale_color_pandar()

pi <- seq(0, 1, .1)
dbeta(pi, 1, 1)

d

d$uninf_prior <- dbeta(d$pi, 1, 1)
d$uninf_post <- dbeta(d$pi, 8, 4)
d

d$uninf_post / d$likelihood

d$weak_prior <- dbeta(d$pi, 2, 2)

d$weak_post <- dbeta(d$pi, 9, 5)
d

d$strong_prior <- dbeta(d$pi, 6, 6)
d$strong_post <- dbeta(d$pi, 13, 9)

colors <- c('Strong' = '#00618f', 'Weak' = '#737c45', 'Uninformative' = '#e3ba0f')

pi <- seq(0, 1, .01)
tmp <- data.frame(pi,
  uninf_prior = dbeta(pi, 1, 1),
  uninf_post = dbeta(pi, 8, 4),
  weak_prior = dbeta(pi, 2, 2),
  weak_post = dbeta(pi, 9, 5), 
  strong_prior = dbeta(pi, 6, 6),
  strong_post = dbeta(pi, 13, 9))

plottable <- reshape(tmp, 
  varying = list(uninf = c('uninf_prior', 'uninf_post'), 
    weak = c('weak_prior', 'weak_post'),
    strong = c('strong_prior', 'strong_post')),
  v.names = c('Uninformative', 'Weak', 'Strong'),
  timevar = 'Verteilung',
  times = c('Prior', 'Posterior'),
  idvar = 'pi',
  direction = 'long') |> 
  reshape(varying = list(c('Uninformative', 'Weak', 'Strong')),
    timevar = 'Prior', 
    v.names = 'Dichte',
    times = c('Uninformative', 'Weak', 'Strong'),
    direction = 'long')

ggplot(plottable, aes(x = pi, y = Dichte, color = Prior, lty = Verteilung)) +
  geom_line(lwd = 1.25) + scale_color_manual(values = colors) +
  geom_vline(xintercept = .7)

d_strong <- subset(d, select = c('pi', 'strong_prior', 'strong_post'))

d_strong$bayes_factor <- d_strong$strong_post / d_strong$strong_prior
d_strong

dbeta(.75, 13, 9) / dbeta(.75, 6, 6)

pbeta(.75, 13, 9, lower.tail = FALSE) / pbeta(.75, 6, 6, lower.tail = FALSE)
