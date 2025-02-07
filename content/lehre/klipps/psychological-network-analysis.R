## # Loading the data from your working directory
## load("eat.rda")

head(eat) # Display the first few rows of the 'eat' dataset





set.seed(123) # set seed to ensure the results reproducible

eat_clean <- na.omit(eat) # Excluding participants with any NA values across all variables

ed <- eat_clean[, 1:11] # choose the variables about 11 symptom subdimensions

library(bootnet) # Load the 'bootnet' package for network estimation

cor_ed <- estimateNetwork(ed, default = 'cor') # correlation network
plot(cor_ed) # Plot the estimated correlation network

save_layout <- plot(cor_ed)$layout # save the layout

pcor_ed <- estimateNetwork(ed, default = 'pcor') # partial correlation network
plot(pcor_ed, layout = save_layout) # used the saved layout 

pcor_ed_sig <- estimateNetwork(ed, default = "pcor", threshold = "sig") # Keep only statistically significant correlations
plot(pcor_ed_sig, layout = save_layout) # used the saved layout 

pcor_ed_lasso <- estimateNetwork(ed, default = "EBICglasso") # EBICglasso Regularization
plot(pcor_ed_lasso, layout = save_layout) # used the saved layout

# Load necessary libraries
library(glasso)
library(ggplot2)
library(reshape2)

# Compute the covariance matrix using pairwise complete observations
cov_matrix <- cov(ed, use = "pairwise.complete.obs") 

# Define a sequence of lambda values for regularization
lambdas <- seq(1, 300, length.out = 100)

# Initialize a matrix to store partial correlations
partial_correlations <- matrix(NA, nrow = length(lambdas), 
                               ncol = sum(upper.tri(cov_matrix)))

# Compute the graphical lasso for each lambda and extract partial correlations
for (i in seq_along(lambdas)) {
  fit <- glasso(cov_matrix, rho = lambdas[i])
  precision <- fit$wi 
  partial_cor <- -cov2cor(precision)[upper.tri(precision)] 
  partial_correlations[i, ] <- partial_cor
}

# Get variable names from the dataset
variable_names <- colnames(ed)

# Generate all possible node pairs
node_pairs <- combn(variable_names, 2, simplify = TRUE)

# Create edge labels for each pair of nodes
edge_labels <- apply(node_pairs, 2, function(x) paste0(x[1], "-", x[2]))

# Prepare data for visualization
plot_data <- data.frame(lambda = lambdas, partial_correlations)
plot_data <- melt(plot_data, id.vars = "lambda", 
                  variable.name = "Edge", value.name = "PartialCorrelation")

# Assign appropriate edge labels
plot_data$Edge <- rep(edge_labels, each = length(lambdas))

# Create the plot of partial correlations vs. lambda (log scale)
plot_glasso <- ggplot(plot_data, aes(x = lambda, y = PartialCorrelation, color = Edge)) +
  geom_line() +
  scale_x_log10() +
  labs(x = expression(lambda~ "(log-Scala)"),
       y = "Partial correlation",
       color = "Kanten") +
  theme_minimal() +
  theme(legend.position = 'none')

plot_glasso

library(qgraph)

# Generate a centrality plot for the partial correlation network
centralityPlot(
  pcor_ed_lasso, # Partial correlation network estimated using Lasso
  include = c("Strength") # Include only 'Strength' as the centrality measure
)

library(qgraph)

centralityPlot(
  pcor_ed_lasso,
  include = c("ExpectedInfluence") # Include only 'ExpectedInfluence' as the centrality measure
)

library(qgraph)

centralityPlot(
  pcor_ed_lasso,
  include = c("Closeness") # Include only 'Closeness' as the centrality measure
)

library(qgraph)

centralityPlot(
  pcor_ed_lasso,
  include = c("Betweenness") # Include only 'Betweenness' as the centrality measure
)

# Perform non-parametric bootstrap with 1000 iterations
boot_diff <- bootnet(
  pcor_ed_lasso,                # The estimated network object
  nBoots = 1000,                # Number of bootstrap samples
  default = "EBICglasso",       # Default method for network estimation
  statistics = "ExpectedInfluence",  # Centrality measure to assess
  type = 'nonparametric',        # Non-parametric bootstrap, very important
  verbose = F 
)

# Plotting the centrality difference results
plot(
  boot_diff,
  statistics = "ExpectedInfluence",  # Plot expected influence differences
  order = "sample",                 # Orders nodes based on sample centrality
  labels = TRUE                     # Displays node labels in the plot
)

library(qgraph)

# Calculate global network measures
smallworldIndex(qgraph(pcor_ed_lasso$graph))


# Perform case-dropping bootstrap to assess stability of expected influence
stab_diff <- bootnet(
  pcor_ed_lasso,       # estimated network
  nBoots = 1000,       # Number of bootstrap samples
  default = "EBICglasso", # Network estimation method
  type = 'case',       # Case-dropping bootstrap, very important
  statistics = c("expectedInfluence"), # Centrality measure to assess
  verbose = F
)


# Calculate the correlation stability coefficient
corStability(stab_diff, cor = 0.7)



plot(stab_diff, "expectedInfluence")
