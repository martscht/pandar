# Beobachtungen
obs <- c(0, 1, 1, 0, 1, 1, 1, 0, 1, 1)

# N
length(obs)

# Erfolgsquote
mean(obs)

# Häufigkeitstabelle der Erfolge
tab <- table(obs)

# Tabelle in den Chi2-Test
chisq.test(tab)

chisq.test(tab)$expected

# Wahrscheinlichkeit händisch bestimmen
choose(10, 7) * .5^7 * (1 - .5)^(10 - 7)

# Gerichtet
pbinom(6, 10, .5, lower.tail = FALSE)

# Ungerichtet
pbinom(6, 10, .5, lower.tail = FALSE) + pbinom(3, 10, .5)

binom.test(7, 10, .5)

choose(10, 7) * .5^7 * (1 - .5)^(10 - 7)

pi <- c(.5, .6, .7, .8, .9, 1)
L <- choose(10, 7) * pi^7 * (1 - pi)^(10 - 7)
d <- data.frame(pi, L)
d

L_H0 <- dbinom(7, 10, .5)
L_H1 <- dbinom(7, 10, .7)

L_H1/L_H0

likeli_plot <- ggplot(d, aes(x = pi, y = L)) + 
  xlim(0, 1) +
  geom_function(fun = dbinom, args = list(x = 7, size = 10)) +
  labs(x = expression(pi), y = 'Likelihood')

likeli_plot + geom_vline(xintercept = .5, lty = 2) +
  annotate('text', x = .48, y = .02, label = 'H[0]', parse = TRUE) +
  geom_vline(xintercept = .7, lty = 2) +
  annotate('text', x = .68, y = .02, label = 'H[1]', parse = TRUE)

uninf <- data.frame(x = rep(seq(0, 1, .005), 3),
  Dichte = c(dbeta(seq(0, 1, .005), 1, 1),
    dbeta(seq(0, 1, .005), 8, 4),
    dbeta(seq(0, 1, .005), 8, 4)),
  Verteilung = as.factor(rep(c('Prior', 'Likelihood', 'Posterior'), each = 201)))
uninf$Verteilung <- relevel(uninf$Verteilung, 'Prior')
colors <- c('Prior' = '#00618f', 'Likelihood' = '#737c45', 'Posterior' = '#e3ba0f')
names(colors) <- levels(uninf$Verteilung)

  ggplot(uninf, aes(x = x, y = Dichte)) +
    geom_line(aes(color = Verteilung), lwd = 1.5) +
    ylim(0, max(uninf$Dichte)) +
    theme_minimal() +
    scale_color_manual(values = colors) +
    theme(legend.position = 'top') +
    labs(x = expression(pi))

weakly <- data.frame(x = rep(seq(0, 1, .005), 3),
  Dichte = c(dbeta(seq(0, 1, .005), 2, 2),
    dbeta(seq(0, 1, .005), 8, 4),
    dbeta(seq(0, 1, .005), 9, 5)),
  Verteilung = as.factor(rep(c('Prior', 'Likelihood', 'Posterior'), each = 201)))
weakly$Verteilung <- relevel(weakly$Verteilung, 'Prior')
ggplot(weakly, aes(x = x, y = Dichte)) +
  geom_line(aes(color = Verteilung), lwd = 1.5) +
  ylim(0, max(weakly$Dichte)) +
  theme_minimal() +
  scale_color_manual(values = colors) +
  theme(legend.position = 'top') +
  labs(x = expression(pi))

strongly <- data.frame(x = rep(seq(0, 1, .005), 3),
  Dichte = c(dbeta(seq(0, 1, .005), 6, 6),
    dbeta(seq(0, 1, .005), 8, 4),
    dbeta(seq(0, 1, .005), 13, 9)),
  Verteilung = as.factor(rep(c('Prior', 'Likelihood', 'Posterior'), each = 201)))
strongly$Verteilung <- relevel(strongly$Verteilung, 'Prior')

ggplot(strongly, aes(x = x, y = Dichte)) +
  geom_line(aes(color = Verteilung), lwd = 1.5) +
  ylim(0, max(strongly$Dichte)) +
  theme_minimal() +
  scale_color_manual(values = colors) +
  theme(legend.position = 'top') +
  labs(x = expression(pi))

binom.test(7, 10, .5)

ki <- binom.test(7, 10, .5)$conf.int
likeli_plot + 
  geom_vline(xintercept = ki[1], lty = 3) + 
  geom_vline(xintercept = ki[2], lty = 3)

ci <- qbeta(c(.025, .975), 13, 9)
ggplot(strongly, aes(x = x, y = Dichte)) +
  geom_line(aes(color = Verteilung), lwd = 1.5, alpha = .25) +
  geom_line(data = strongly[strongly$Verteilung == 'Posterior',], aes(color = Verteilung), lwd = 1.5) +
  ylim(0, max(strongly$Dichte)) +
  theme_minimal() +
  scale_color_manual(values = colors) +
  theme(legend.position = 'top') +
  labs(x = expression(pi)) +
  geom_vline(xintercept = ci[1], lty = 2) + 
  geom_vline(xintercept = ci[2], lty = 2)

ggplot(strongly, aes(x = x, y = Dichte)) +
  geom_line(aes(color = Verteilung), lwd = 1.5, alpha = .25) +
  geom_line(data = strongly[strongly$Verteilung == 'Posterior',], aes(color = Verteilung), lwd = 1.5) +
  geom_line(data = strongly[strongly$Verteilung == 'Prior',], aes(color = Verteilung), lwd = 1.5) +
  ylim(0, max(strongly$Dichte)) +
  geom_vline(xintercept = .5, lty = 2) +
  geom_ribbon(data = strongly[strongly$x >= .5 & strongly$Verteilung == 'Prior', ], 
    aes(ymax = Dichte, fill = Verteilung), ymin = 0, alpha = .25) +
  geom_ribbon(data = strongly[strongly$x >= .5 & strongly$Verteilung == 'Posterior', ], 
    aes(ymax = Dichte, fill = Verteilung), ymin = 0, alpha = .25) +
  theme_minimal() +
  scale_color_manual(values = colors) +
  scale_fill_manual(values = colors) +
  theme(legend.position = 'top') +
  guides(fill = 'none') + 
  labs(x = expression(pi))
