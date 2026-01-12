---
title: "Dynamic Network Comparison" 
type: post
date: '2025-12-22'
slug: dynamic-network-comparison 
categories: ["DYNAMIC"] 
tags: [] 
subtitle: ''
summary: 'This page contains a collection of frequently asked questions about the comparison of dynamic network models. The questions were collected as part of the methodological consultation within the DYNAMIC project.' 
authors: [siepe] 
weight: 2
lastmod: "2026-01-12"
featured: no
banner: 
  image: "/header/lightbeams_converging_night.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/724752)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /extras/dynamic/dynamic-network-comparison/
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /extras/dynamic/dynamic-network-comparison.R
output:
  html_document:
    keep_md: true
---




## How can dynamic network models be compared across individuals or groups?


When working with dynamic network models, researchers may be interested in comparing these models across individuals or groups. For example, one may want to test if the network structure differs between two clinical groups. Such comparisons have received great attention in cross-sectional network models (see, for example, Haslbeck, 2022). Recently, several methods have been proposed to compare dynamic network models. 
When working with person-specific models, researchers may also want to test if the estimated network structure is different after an intervention. For example, one may want to test if a dynamic network is less strongly connected after an intervention. 

Below, we outline some potential approaches to compare dynamic network models in these contexts. We differentiate between two scenarios: (1) comparing person-specific (n = 1) network models, and (2) comparing network models across multiple individuals or groups (n > 1). We provide simple example code snippets in R for each approach, which we typically borrow from the respective package documentations.

In general, many potential models can be portrayed and interpreted as dynamic networks. For example, one could fit a dynamic structural equation model (DSEM) and extract the parameters to create a network representation. Similarly, one could fit a continuous-time model and extract parameters to create a network representation. In the case of DSEM in particular, traditional SEM model comparison approaches can be used to compare models across individuals or groups. Therefore, the above approaches are not exhaustive, and researchers should carefully consider which is most suitable for their research question and data.


## How can n = 1 dynamic network models be compared?

For person-specific network models, there are several methods available to compare network structures before and after an intervention (for a given individual) or between individuals. Below, we outline four different approaches to compare n = 1 dynamic network models.

Typically, these models require many time points (e.g., 100 or more) to obtain reliable estimates of the dynamic network structure. However, there are no strict rules on the minimum number of time points required, as this depends on various factors such as the number of variables in the model, the expected effect sizes, and the estimation method used. For sample size planning, we recommend to take a look at simulation studies that have investigated the performance of the specific estimation method you plan to use. Alternatively, Zhang et al. (2025) have proposed simulation-based sample size planning approaches for person-specific network models. 



### Individual Network Invariance Test (INIT)

The Individual Network Invariance Test (INIT; Hoekstra et al., 2024) uses techniques from structural equation modeling to formally test whether two dynamic network models differ significantly from each other. To do so, a model that constrains all parameters to be equal across two networks is compared to a model that allows all parameters to differ across two networks. It can do so for temporal and contemporaneous networks simultaneously or separately.

Here is a simple example taken from the package documentation of the `INIT` package on [GitHub](https://github.com/RiaHoekstra/INIT):


``` r
# If necessary, install the package
# install.packages("remotes")
# remotes::install_github("RiaHoekstra/INIT")

# Load the INIT package
library(INIT)

# Load data of two individuals: 
data <- INIT::data

# Compare networks with default arguments:
INIT(data = data, idvar = colnames(data)[1], vars = colnames(data)[2:7])
```

```
## Warning: `funs()` was deprecated in dplyr 0.8.0.
## ℹ Please use a list of either functions or lambdas:
## 
## # Simple named list: list(mean = mean, median = median)
## 
## # Auto named with `tibble::lst()`: tibble::lst(mean, median)
## 
## # Using lambdas list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
## ℹ The deprecated feature was likely used in the psychonetrics package.
##   Please report the issue at <https://github.com/SachaEpskamp/psychonetrics/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

```
## 
##  ----- INIT results -----
## 
##  The model without equality constraints is preferred. 
## 
##  INIT summary 
##    - AIC homogeneity model: 6847.434 
##    - AIC heterogeneity model: 6771.743 
##    - delta AIC: -75.69085 
## 
##  input summary 
##    - number of variables in the network: 6 
##    - estimator used: ML 
##    - estimated network type: saturated 
##    - homogeneity test: overall
```

A significant results indicates that the networks are not invariant, that is, they differ significantly from each other. This test was used, for example, in Ebrahimi et al. (2024) to compare patients with major depressive disorder with similar severity levels.

### Invariance Partial Pruning (IVPP)

The Invariance Partial Pruning (IVPP; Du et al., 2025) is another approach to compare networks that is based on the idea of the INIT approach. However, instead of being restricted to a global test of invariance, it uses a stepwise procedure to identify if networks differ, and if so, which specific parameters differ across networks. It works for individual dynamic network models (n = 1) as well as for panel dynamic network models (n > 1).

Here is a simple example taken from the package documentation of the `ivpp` package on [CRAN](https://doi.org/10.32614/CRAN.package.ivpp):



``` r
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
```

```
## 
## Results of partial pruning are explratory. Be careful to interpret if group-equality constraints decreased AIC or BIC
```

The results indicate if networks differ, and if so, which specific parameters differ across networks.

### Bayesian Approach

Siepe et al. (2024) proposed a Bayesian approach to compare dynamic network models for a single individual. It works by estimating the posterior distribution of two dynamic network models and comparing these distributions to reference distributions that merely reflect sampling variability. 

Again, here is an example taken from the package documentation of the `tsnet` package on [CRAN](https://doi.org/10.32614/CRAN.package.tsnet):


``` r
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
```

```
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 1).
## Chain 1: 
## Chain 1: Gradient evaluation took 0.000889 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 8.89 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1: 
## Chain 1: 
## Chain 1: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 1: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 1: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 1: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 1: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 1: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 1: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 1: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 1: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 1: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 1: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 1: 
## Chain 1:  Elapsed Time: 11.001 seconds (Warm-up)
## Chain 1:                71.423 seconds (Sampling)
## Chain 1:                82.424 seconds (Total)
## Chain 1: 
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 2).
## Chain 2: 
## Chain 2: Gradient evaluation took 0.00041 seconds
## Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 4.1 seconds.
## Chain 2: Adjust your expectations accordingly!
## Chain 2: 
## Chain 2: 
## Chain 2: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 2: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 2: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 2: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 2: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 2: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 2: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 2: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 2: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 2: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 2: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 2: 
## Chain 2:  Elapsed Time: 10.292 seconds (Warm-up)
## Chain 2:                80.367 seconds (Sampling)
## Chain 2:                90.659 seconds (Total)
## Chain 2: 
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 3).
## Chain 3: 
## Chain 3: Gradient evaluation took 0.000425 seconds
## Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 4.25 seconds.
## Chain 3: Adjust your expectations accordingly!
## Chain 3: 
## Chain 3: 
## Chain 3: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 3: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 3: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 3: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 3: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 3: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 3: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 3: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 3: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 3: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 3: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 3: 
## Chain 3:  Elapsed Time: 10.986 seconds (Warm-up)
## Chain 3:                82.05 seconds (Sampling)
## Chain 3:                93.036 seconds (Total)
## Chain 3: 
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 4).
## Chain 4: 
## Chain 4: Gradient evaluation took 0.000428 seconds
## Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 4.28 seconds.
## Chain 4: Adjust your expectations accordingly!
## Chain 4: 
## Chain 4: 
## Chain 4: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 4: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 4: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 4: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 4: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 4: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 4: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 4: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 4: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 4: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 4: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 4: 
## Chain 4:  Elapsed Time: 11.879 seconds (Warm-up)
## Chain 4:                88.841 seconds (Sampling)
## Chain 4:                100.72 seconds (Total)
## Chain 4:
```

``` r
net_2 <- stan_gvar(data_2[,-7],
                   iter_sampling = 4000,
                   n_chains = 4)
```

```
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 1).
## Chain 1: 
## Chain 1: Gradient evaluation took 0.000417 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 4.17 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1: 
## Chain 1: 
## Chain 1: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 1: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 1: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 1: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 1: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 1: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 1: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 1: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 1: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 1: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 1: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 1: 
## Chain 1:  Elapsed Time: 6.243 seconds (Warm-up)
## Chain 1:                49.267 seconds (Sampling)
## Chain 1:                55.51 seconds (Total)
## Chain 1: 
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 2).
## Chain 2: 
## Chain 2: Gradient evaluation took 0.000423 seconds
## Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 4.23 seconds.
## Chain 2: Adjust your expectations accordingly!
## Chain 2: 
## Chain 2: 
## Chain 2: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 2: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 2: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 2: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 2: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 2: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 2: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 2: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 2: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 2: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 2: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 2: 
## Chain 2:  Elapsed Time: 6.459 seconds (Warm-up)
## Chain 2:                47.521 seconds (Sampling)
## Chain 2:                53.98 seconds (Total)
## Chain 2: 
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 3).
## Chain 3: 
## Chain 3: Gradient evaluation took 0.000437 seconds
## Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 4.37 seconds.
## Chain 3: Adjust your expectations accordingly!
## Chain 3: 
## Chain 3: 
## Chain 3: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 3: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 3: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 3: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 3: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 3: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 3: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 3: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 3: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 3: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 3: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 3: 
## Chain 3:  Elapsed Time: 6.144 seconds (Warm-up)
## Chain 3:                48.805 seconds (Sampling)
## Chain 3:                54.949 seconds (Total)
## Chain 3: 
## 
## SAMPLING FOR MODEL 'VAR_wishart' NOW (CHAIN 4).
## Chain 4: 
## Chain 4: Gradient evaluation took 0.000435 seconds
## Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 4.35 seconds.
## Chain 4: Adjust your expectations accordingly!
## Chain 4: 
## Chain 4: 
## Chain 4: Iteration:    1 / 4500 [  0%]  (Warmup)
## Chain 4: Iteration:  500 / 4500 [ 11%]  (Warmup)
## Chain 4: Iteration:  501 / 4500 [ 11%]  (Sampling)
## Chain 4: Iteration: 1000 / 4500 [ 22%]  (Sampling)
## Chain 4: Iteration: 1500 / 4500 [ 33%]  (Sampling)
## Chain 4: Iteration: 2000 / 4500 [ 44%]  (Sampling)
## Chain 4: Iteration: 2500 / 4500 [ 55%]  (Sampling)
## Chain 4: Iteration: 3000 / 4500 [ 66%]  (Sampling)
## Chain 4: Iteration: 3500 / 4500 [ 77%]  (Sampling)
## Chain 4: Iteration: 4000 / 4500 [ 88%]  (Sampling)
## Chain 4: Iteration: 4500 / 4500 [100%]  (Sampling)
## Chain 4: 
## Chain 4:  Elapsed Time: 6.537 seconds (Warm-up)
## Chain 4:                50.565 seconds (Sampling)
## Chain 4:                57.102 seconds (Total)
## Chain 4:
```

``` r
# Compare networks
compare_13 <- compare_gvar(net_1, 
                           net_2,
                           return_all = TRUE,
                           n_draws = 1000)

# Print summary of results
print(compare_13)                   
```

```
## ### Summary of the Norm-Based Comparison Test ###
## 
## #--- General Summary ---#
## In the temporal network 2 of the 2 comparisons were significant.
## In the contemporaneous network 2 of the 2 comparisons were significant.
## 
## #--- Model-specific Results ---#
## For mod_a 0 of the reference distances of the temporal network and 0 of the reference distances of the contemporaneous network were larger than the empirical distance.
## 
## For mod_b 0 of the reference distances of the temporal network and 0 of the reference distances of the contemporaneous network were larger than the empirical distance.
```

A positive result indicates that it's unlikely that the two networks were generated from the same underlying parameters.

### Simple Permutation Test
Haslbeck (2025) proposed a simple test to compare two n = 1 dynamic network models, which is implemented in the `mnet` package. The test works by estimating a simple VAR model, and then either sampling from a reference distribution without differences, or by using a parametric test to compare the estimated parameters across two models. 

Here is an example based on the package documentation of `mnet` on [CRAN](https://doi.org/10.32614/CRAN.package.mnet).


``` r
# If necessary, install the packages
# install.package(mlVAR)
# install.package(mnet)

library(mlVAR) # for simulateVAR() function
library(mnet)
```

```
## This is mnet 0.1.4
```

```
## Please report issues on Github: https://github.com/jmbh/mnet/issues
```

``` r
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
```

Significant results indicate that parameters differ across the two networks.

## How can n > 1 dynamic network models be compared?

When comparing group-based models, the number of timepoints per individual can often be lower (e.g., 50-100 time points), as information is pooled across individuals within each group. However, the exact number of time points required still depends on various factors such as the number of variables in the model, the expected effect sizes, the number of individuals per group, and the estimation method used. However, there should be a sufficient number of individuals per group to obtain reliable estimates of the differences between groups.
As explained above, the IVPP approach can also be used for panel network models (n > 1). Below, we outline an additional approach to compare dynamic network models across multiple individuals or groups.


### Permutation Test for mlVAR Models

Here, we again use the `mnet` package to perform a permutation test to compare mlVAR models across groups. It works by permuting group labels and estimating the group differences in parameters under the null hypothesis of no group differences.


``` r
# If necessary, install the package
# install.package(mnet)

library(mnet)

# Use simulated example data loaded with package
head(ExampleData)
```

```
##           V1         V2         V3 id group
## 1 -0.5503574  2.3730731 -0.9546494  1     1
## 2 -0.8676930  2.6043886  0.1419776  1     1
## 3 -1.0098863  1.9953243  0.8989440  1     1
## 4 -2.2597404  1.5433871  0.2017678  1     1
## 5 -1.4791477 -0.3571881 -0.6923630  1     1
## 6 -0.6629657 -0.2803782 -0.1600937  1     1
```

``` r
# Call Permutation test
out <- mlVAR_GC(data = ExampleData,
vars = c("V1", "V2", "V3"),
idvar = "id",
groups = "group",
nCores = 2, # choose max cores possible on your machine
nP = 2) # Should be much more in practice, see paper!
```

```
## 
  |                                                                                                                                    
  |                                                                                                                              |   0%
```

```
## Warning in e$fun(obj, substitute(ex), parent.frame(), e$data): already exporting variable(s): m_data_cmb, vars, idvar, estimator,
## contemporaneous, temporal, totalN, v_Ns, v_ids, pb, pbar, dayvar, beepvar, paired, quiet_library
```

```
## 
  |                                                                                                                                    
  |==============================================================================================================================| 100%
```

``` r
# P-values for the five parameter types:
out$Pval
```

```
## $Lagged_fixed
##      [,1] [,2] [,3]
## [1,]    1  0.0    0
## [2,]    0  0.5    1
## [3,]    0  1.0    1
## 
## $Lagged_random
##      [,1] [,2] [,3]
## [1,]  1.0    0  0.0
## [2,]  0.5    0  0.5
## [3,]  0.0    1  0.0
## 
## $Contemp_fixed
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]  1.0   NA   NA
## [3,]  0.5    0   NA
## 
## $Contemp_random
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]  1.0   NA   NA
## [3,]  0.5    1   NA
## 
## $Between
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]    0   NA   NA
## [3,]    0    1   NA
```

``` r
# The observed group differences (i.e., the test statistics)
# Can be found in:
out$EmpDiffs
```

```
## $Lagged_fixed
## , , 1
## 
##             V1           V2           V3
## V1 -0.00252620 -0.343710677  0.019928177
## V2  0.02702579  0.009729344 -0.002083037
## V3 -0.01797542 -0.010346780 -0.002122644
## 
## 
## $Lagged_random
## , , 1
## 
##               V1           V2         V3
## V1 -0.0001694807  0.033679705 -0.0133229
## V2 -0.0247214499 -0.017000309  0.0253878
## V3 -0.0199360377 -0.009975728  0.0285887
## 
## 
## $Contemp_fixed
##              V1           V2          V3
## V1  0.000000000 -0.005761086 -0.01054800
## V2 -0.005761086  0.000000000  0.01351376
## V3 -0.010548004  0.013513759  0.00000000
## 
## $Contemp_random
##             V1          V2          V3
## V1  0.00000000 -0.00246086  0.01120551
## V2 -0.00246086  0.00000000 -0.04474057
## V3  0.01120551 -0.04474057  0.00000000
## 
## $Between
##            V1          V2         V3
## V1  0.0000000 -0.65289398 0.15261090
## V2 -0.6528940  0.00000000 0.06414174
## V3  0.1526109  0.06414174 0.00000000
```

Significant results indicate that parameters differ across groups.

# References

Du, X., Johnson, S. U., & Epskamp, S. (2025). The Invariance Partial Pruning Approach to The Network Comparison in Time-Series and Panel Data. PsyArXiv Preprint. https://doi.org/10.31234/osf.io/vb8dz_v1

Ebrahimi, O. V., Borsboom, D., Hoekstra, R. H. A., Epskamp, S., Ostinelli, E. G., Bastiaansen, J. A., & Cipriani, A. (2024). Towards precision in the diagnostic profiling of patients: leveraging symptom dynamics as a clinical characterisation dimension in the assessment of major depressive disorder. *The British Journal of Psychiatry, 224*(5), 157–163. [https://doi.org/10.1192/bjp.2024.19](https://doi.org/10.1192/bjp.2024.19) 

Haslbeck, J. M. (2022). Estimating group differences in network models using moderation analysis. *Behavior Research Methods, 54*(1), 522-540. [https://doi.org/10.3758/s13428-021-01637-y](https://doi.org/10.3758/s13428-021-01637-y)

Haslbeck, J. (2025). mnet: Modeling group differences and moderation effects in statistical network models (Version 0.1.4) [R package]. Comprehensive R Archive Network (CRAN). https://doi.org/10.32614/CRAN.package.mnet

Hoekstra, R. H. A., Epskamp, S., Nierenberg, A. A., Borsboom, D., & McNally, R. J. (2024). Testing similarity in longitudinal networks: The Individual Network Invariance Test. *Psychological methods*. Advance online publication. [https://doi.org/10.1037/met0000638](https://doi.org/10.1037/met0000638)

Siepe, B. S., Kloft, M., & Heck, D. W. (2024). Bayesian estimation and comparison of idiographic network models. *Psychological methods*. Advance online publication. [https://doi.org/10.1037/met0000672](https://doi.org/10.1037/met0000672)

Zhang, Y., Revol, J., Lafit, G., Ernst, A. F., Razum, J., Ceulemans, E., & Bringmann, L. F. (2025). Meeting the Bare Minimum: Quality Assessment of Idiographic Temporal Networks Using Power Analysis and Predictive-Accuracy Analysis. *Advances in Methods and Practices in Psychological Science, 8*(4). [https://doi.org/10.1177/25152459251372116](https://doi.org/10.1177/25152459251372116)

