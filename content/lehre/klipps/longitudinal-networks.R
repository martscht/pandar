## load("COVID19_dynamic_analyses_cleaned.Rdata")

colnames(data)[5:22] <- c("Insp", "Alert", "Exc", "Ent", 
                          "Det","Afraid", "Upset", "Nervous", 
                          "Scared", "Dist", "LoI", "DepMood", 
                          "SleepDis", "Fatigue", "Appet", 
                          "Worth", "Con", 
                          "PsychMot")

head(data)

# Load the mlVAR package
library(mlVAR)

# Define the variables to include in the VAR model
variables <- c("Fatigue", "DepMood")

# Estimate the multilevel VAR model
model_mlVAR <- mlVAR(
  data = data,          # The dataset containing the time-series data
  vars = variables,     # The variables to include in the model
  idvar = "sub_id",     # The variable identifying individual subjects
  beepvar = "measurement", # The variable indicating the measurement occasion
  lags = 1,             # The number of lags to include in the model
  verbose = FALSE       # Suppress verbose output
)

# Plot the temporal network
plot(model_mlVAR,          # The mlVAR model object containing the estimated networks
     type = "temporal",    # Specify that we want to plot the temporal network
     nonsig = "hide",      # Hide non-significant edges in the plot
     layout = "circle",    # Arrange nodes in a circular layout
     theme = "colorblind", # Apply a colorblind-friendly theme
     edge.labels = TRUE)   # Display edge labels indicating the strength of connections

# Plot the contemporaneous network
plot(model_mlVAR,          # The mlVAR model object containing the estimated networks
     type = "contemporaneous",    # Specify that we want to plot the contemporaneous network
     nonsig = "hide",      # Hide non-significant edges in the plot
     layout = "circle",    # Arrange nodes in a circular layout
     theme = "colorblind", # Apply a colorblind-friendly theme
     edge.labels = TRUE)   # Display edge labels indicating the strength of connections

# Plot the between-person network
plot(model_mlVAR,          # The mlVAR model object containing the estimated networks
     type = "between",    # Specify that we want to plot the between-person network
     nonsig = "hide",      # Hide non-significant edges in the plot
     layout = "circle",    # Arrange nodes in a circular layout
     theme = "colorblind", # Apply a colorblind-friendly theme
     edge.labels = TRUE)   # Display edge labels indicating the strength of connections

# Load necessary libraries
library(ggplot2)   # For data visualization
library(reshape2)  # For reshaping data (converting matrix to long format)

# Define variable names
variables <- c("β01", "β11", "β12", "β02", "β21", "β22")

# Create a 6x6 matrix representing estimation inclusion
matrix_data <- matrix(c(
  1, 0.5, 0.5, 0, 0, 0,
  0.5, 1, 0.5, 0, 0, 0,
  0.5, 0.5, 1, 0, 0, 0,
  0, 0, 0, 1, 0.5, 0.5,
  0, 0, 0, 0.5, 1, 0.5,
  0, 0, 0, 0.5, 0.5, 1
), nrow = 6, byrow = TRUE)[, 6:1]

# Convert matrix to a data frame for ggplot
df <- melt(matrix_data)
colnames(df) <- c("Var1", "Var2", "Value")  # Rename columns for clarity

# Assign factor labels to match variable names
df$Var1 <- factor(df$Var1, levels = 1:6, labels = rev(variables))
df$Var2 <- factor(df$Var2, levels = 1:6, labels = variables)

# Assign color labels based on estimation type
df$Fill <- factor(df$Value, levels = c(1, 0.5, 0), 
                  labels = c("Included in both", "Only in correlated", "Not included"))

# Plot heatmap using ggplot2
ggplot(df, aes(x = Var2, y = Var1, fill = Fill)) +
  geom_tile(color = "black") +  # Draw tiles with black borders
  scale_fill_manual(values = c("steelblue", "lightblue", "white")) +  # Assign colors
  theme_minimal() +  # Use a minimal theme for a clean look
  labs(title = "Covariance Matrix Estimation",
       x = "", y = "", fill = "Estimation Type") +  # Set title and labels
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

# Load ggplot2 for visualization
library(ggplot2)

# Plot DepMood over time using LOESS smoothing

ggplot(data, 
       aes(x = measurement_date, y = DepMood)) +  # Set x-axis as time and y-axis as DepMood levels
  geom_smooth(method = "loess", se = TRUE, color = "blue") + # Add LOESS smoothing with confidence interval 
  xlab(" ") +  # Remove x-axis label for cleaner visualization
  ylab(" ")  # Remove y-axis label for cleaner visualization
  


# Load required packages
library(lme4)
library(lmerTest)  # For p-values in MLM

# Fit the Linear Mixed Model (LMM)
MLM_model <- lmer(DepMood  ~ measurement + (measurement | sub_id), data = data)

# View model summary
summary(MLM_model)

# Fit a linear regression model (Depressed Mood ~ Time)
lm_model <- lm(DepMood ~ measurement, data = data)

residuals <- residuals(lm_model)

# Extract the temporal network
temp1 <- getNet(model_mlVAR, "temporal", subject = 1) # extract from the first person
temp2 <- getNet(model_mlVAR, "temporal", subject = 2) # extract from the second person


mean(abs(temp1)) # calculate the network density for the fitst person's temporal network

# Load the mgm package
library(mgm)

# Define model parameters
variables <- c("Fatigue", "DepMood")  # Variables to include in the model
lags <- 1  # Number of lags to include in the model
bandwidth <- 1  # Bandwidth parameter for kernel smoothing; adjust based on data characteristics

# Remove rows with missing values from the dataset
data_clean <- na.omit(data)

# Estimate the time-varying VAR model
tvvar_model <- tvmvar(
  data = data_clean[, variables],      # Use the cleaned data with selected variables
  type = rep("g", length(variables)),  # Assume variables are continuous ("g" denotes Gaussian)
  level = rep(1, length(variables)),   # For continuous variables, set level to 1
  lags = lags,                         # Specify the number of lags
  estpoints = seq(0, 1, length = 100), # Proportional locations of estimation points
  bandwidth = bandwidth,                # Bandwidth parameter for kernel smoothing
  pbar = F
)

# Extract parameter estimates
parameter_values <- tvvar_model$wadj[2, 1, 1, ] # here we only extact one effect as example

# Plot the parameter estimates over time
plot(parameter_values, type = "l", ylim = c(0, 0.4),
     lwd = 2, ylab = "Parameter Value", xlab = "Estimation Points",
     main = "Time-varying cross lagged effect of Fatigue on Depressed Mood")
