# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

library(qgraph)
people <- matrix(data =
                   c(0,1,0,0,1,0,0,0,0,1,
                     1,0,1,1,0,1,1,0,0,0,
                     0,1,0,0,1,1,1,0,0,0,
                     0,1,0,0,0,0,0,1,1,0,
                     1,0,1,0,0,1,1,0,0,1,
                     0,1,1,0,1,0,1,0,0,0,
                     0,1,1,0,1,1,0,0,0,0,
                     0,0,0,1,0,0,0,0,1,0,
                     0,0,0,1,0,0,0,1,0,1,
                     1,0,0,0,1,0,0,0,1,0), 
            nrow = 10, ncol = 10)
rownames(people)<- c("Anna", "Chris","Rosa","Jess","Lars","Uwe","Lina","Lucie","Stefan","Miriam")
colnames(people)<- c("Anna", "Chris","Rosa","Jess","Lars","Uwe","Lina","Lucie","Stefan","Miriam")
labs <- c("Anna", "Chris","Rosa","Jess","Lars","Uwe","Lina","Lucie","Stefan","Miriam")



qgraph(people,layout = "spring",color = "yellow", label.cex = c(1,1,1,1,0.9,1,1,1,1,1.1), labels = labs, edge.color="black")

raw_data <- readRDS(url("https://osf.io/awz3d/download"))
names(raw_data) <- c("observe", "describe", "awaren.",
                     "nonjudg.",
                     "nonreact.", "interest", 
                     "emotions",  "sleep",
                     "tired",  "appetite", "selfimage",
                     "concentration.", "speed")
raw_data <- raw_data[,6:13]
reg_net <- bootnet::estimateNetwork(raw_data, default = "EBICglasso", nlambda = 100, tuning = 0.5)
plot(reg_net, labels = T, nodeNames = names(raw_data)) 

input <- matrix(c(
  0,1,1,1,
  0,0,1,0,
  0,0,0,1,
  0,0,0,0),4,4,byrow=TRUE)
qgraph(input)

raw_data <- readRDS(url("https://osf.io/awz3d/download"))

head(raw_data)

names(raw_data) <- c("observe", "describe", "awaren.", "nonjudg.",
                     "nonreact.", "interest",  "emotions",  "sleep",
                     "tired",  "appetite", "selfim.",
                     "concentr.", "speed")

## install.packages("bootnet")

library(bootnet)

cor_net <- estimateNetwork(raw_data, default = "cor")
summary(cor_net)

plot(cor_net)

cor_net$graph

pcor_net <- estimateNetwork(raw_data, default = "pcor")
summary(pcor_net)

plot(pcor_net)

reg_net <- estimateNetwork(raw_data, default = "EBICglasso",
                           nlambda = 100, tuning = 0.5)
summary(reg_net)

reg_net$results$optnet

reg_net$results$lambda

reg_net$results$results$wi[,,100]

reg_net$results$ebic

reg_net2 <- estimateNetwork(raw_data, default = "EBICglasso",
                           nlambda = 100, tuning = 2)
summary(reg_net2)

plot(reg_net)

library(qgraph)

centrality_indices <- centrality(graph = reg_net$graph)

centrality_indices$OutDegree

centralityPlot(reg_net, include = c("Strength"))

centralityPlot(reg_net, scale = "raw", include = c( "Strength"))

set.seed(2023)
boot1 <- bootnet(reg_net, nBoots = 100, nCores = 1)
plot(boot1, order = "sample", labels = F)

set.seed(2023)
boot2 <- bootnet(reg_net,   nBoots = 300,
                 statistics = c("strength"), 
                 type = "case", caseMin = 0.05,
                 caseMax = 0.75, caseN = 15,
                 nCores = 1)
plot(boot2, c("strength"))

corStability(boot2, cor = 0.7)

centrality_indices$Closeness

centrality_indices$Betweenness

centralityPlot(reg_net, include = c("Closeness", "Betweenness"))

set.seed(2023)
boot3 <- bootnet(reg_net,   nBoots = 300,
                 statistics = c("betweenness", "closeness"), 
                 type = "case", caseMin = 0.05,
                 caseMax = 0.75, caseN = 15,
                 nCores = 1)
plot(boot3, c("betweenness","closeness"))

corStability(boot3, cor = 0.7)
