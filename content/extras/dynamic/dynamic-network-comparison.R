# If necessary, install the package
# install.packages("remotes")
# remotes::install_github("RiaHoekstra/INIT")

# Load the INIT package
library(INIT)

# Load data of two individuals: 
data <- INIT::data

# Compare networks with default arguments:
INIT(data = data, idvar = colnames(data)[1], vars = colnames(data)[2:7])

# If necessary, install the package
# install.packages("IVPP")

library(IVPP)

# Generate an n = 1 GVAR network
net_ls <- gen_tsGVAR(n_node = 6,
                     p_rewire_temp = 0.5,
                     p_rewire_cont = 0.5,
                     n_persons = 2)

# net_ls$beta contains the temporal networks for both persons
# net_ls$kappa contains the contemporaneous networks for both persons

# Generate the data for 300 timepoints
data <- sim_tsGVAR(beta_base_ls = net_ls$beta, 
                   kappa_base_ls = net_ls$kappa,
                   n_time = 300)

# global test on both networks
omnibus_both <- IVPP_tsgvar(data,
                            vars = paste0("V",1:6),
                            idvar = "id",
                            g_test_net = "both",
                            net_type = "sparse",
                            partial_prune = FALSE)

# partial prune on both networks
pp_both <- IVPP_tsgvar(data,
                       vars = paste0("V",1:6),
                       idvar = "id",
                       global = FALSE,
                       partial_prune = TRUE,
                       prune_net = "both")                             


# If necessary, install the package
# install.packages("tsnet")

library(tsnet)

# Load simulated time series data of two individuals
data(ts_data)
data_1 <- subset(ts_data, id == "ID1")
data_2 <- subset(ts_data, id == "ID2")

# Estimate networks
# (You should perform preprocessing/detrending etc. in a real use case)
# This takes a while to run
net_1 <- stan_gvar(data_1[,-7],
                   iter_sampling = 4000,
                   n_chains = 4)
net_2 <- stan_gvar(data_2[,-7],
                   iter_sampling = 4000,
                   n_chains = 4)

# Compare networks
compare_13 <- compare_gvar(net_1, 
                           net_2,
                           return_all = TRUE,
                           n_draws = 1000)

# Print summary of results
print(compare_13)                   


# If necessary, install the packages
# install.package(mlVAR)
# install.package(mnet)

library(mlVAR) # for simulateVAR() function
library(mnet)

# Specify simple VAR model
p <- 4
A1 <- diag(p) * 0.8
A2 <- diag(p) * 0.8
A2[2,1] <- 0.7

# Simulate datasets
Nt <- 300
set.seed(13) # for reproducibility
data1_x <- simulateVAR(A1, means=rep(0, p), Nt = Nt, residuals=.1)
data2_x <- simulateVAR(A2, means=rep(0, p), Nt = Nt, residuals=.1)

# Add beep and day vars
dayvar1 <- dayvar2 <- rep(1:(Nt/5), each=5)
beepvar1 <- beepvar2 <- rep(1:5, Nt/5)

# Add grouping var
groups1 <- rep(1, Nt)
groups2 <- rep(2, Nt)

# Combine
data1 <- data.frame(cbind(dayvar1, beepvar1, groups1, data1_x))
data2 <- data.frame(cbind(dayvar2, beepvar2, groups2, data2_x))
colnames(data1) <- colnames(data2) <- c("dayvar", "beepvar", "groups", paste0("V", 1:4))
data <- rbind(data1, data2)

# Call
out <- VAR_GC(data = data,
vars = 4:7,
dayvar = 1,
beepvar = 2,
groups = 3)

# If necessary, install the package
# install.package(mnet)

library(mnet)

# Use simulated example data loaded with package
head(ExampleData)

# Call Permutation test
out <- mlVAR_GC(data = ExampleData,
vars = c("V1", "V2", "V3"),
idvar = "id",
groups = "group",
nCores = 2, # choose max cores possible on your machine
nP = 2) # Should be much more in practice, see paper!

# P-values for the five parameter types:
out$Pval

# The observed group differences (i.e., the test statistics)
# Can be found in:
out$EmpDiffs

