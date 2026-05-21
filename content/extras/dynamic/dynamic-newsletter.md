---
title: "DYNAMIC Newsletter" 
type: post
date: '2025-12-22'
slug: dynamic-newsletter
categories: ["DYNAMIC"] 
tags: [] 
subtitle: ''
summary: 'This page contains a collection of newsletters distributed as part of the methodological consultation within the DYNAMIC project. These newsletters highlight recent papers covering potentially interesting methodological ideas in psychological network analysis and more general ESM research. However, the lists of papers are not intended to be exhaustive.' 
authors: [siepe, nehler] 
weight: 3
lastmod: "2026-05-21"
featured: no
banner: 
  image: "/header/work_desktop.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/724752)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /extras/dynamic/dynamic-newsletter
  # - icon_pack: fas
  #   icon: terminal
  #   name: Code
  #   url: /extras/dynamic/cross-sectional-design.R
output:
  html_document:
    keep_md: true
---





## Newsletter 2026-01

Again, we have some fresh papers for you. In this newsletter, we are including work on (1) a database of openly available experience sampling datasets, (2) a tutorial on a package for Bayesian multilevel time series modeling, (3) a package for estimation methods for cross-sectional networks that enable for better handling of missing data, and (4) an article on modeling associations between variables measured at different frequencies.


1. Siepe, B. S., Haslbeck, J. M. B., Kloft, M., Büchner, A., Zhang, Y., Fried, E. I., & Heck, D. W. (2025). Introducing openESM: A database of openly available experience sampling datasets. [https://doi.org/10.31234/osf.io/qfdtb_v1](https://doi.org/10.31234/osf.io/qfdtb_v1)

    * Experience sampling studies are resource-intensive to conduct, yet single studies often lack the statistical power to answer research questions conclusively. This makes multi-dataset analyses essential but difficult due to scattered, hard-to-access data.
    * We introduce openESM, an open-source harmonized database of currently 60 openly available ESM datasets comprising over 16,000 participants and 740,000 observations.
    * The database enables substantive research across contexts, methodological research on ESM design choices, and statistical methods development. We demonstrate its potential through an analysis of within-person affect correlations with more than 500,000 data points, finding a large negative momentary correlation between positive and negative affect (–0.49, 95% CI: [–0.54, –0.42]).
    * You can search and filter all data at [https://openesmdata.org](https://openesmdata.org) and download them via our R and Python packages. We are also actively seeking volunteers to help us expand the database and enhance its functionality.

2. Koslowski, K., Münch, F. F., Koch, T., & Holtmann, J. (2025). A Tutorial on Bayesian Multilevel Latent Time Series Models using Stan with the mlts R-package. [https://doi.org/10.31234/osf.io/j85tp_v1](https://doi.org/10.31234/osf.io/j85tp_v1)

    * Many statistical models that are well-suited for intensive longitudinal data require implementation of relatively complex algorithms in statistical software.
    * The [`mlts` package](https://doi.org/10.32614/CRAN.package.mlts) introduced in this tutorial provides a user-friendly interface to estimate Bayesian multilevel time series models, including vector autoregressive models and dynamic structural equation models. 
    * These enable modeling of multiple groups, between-person covariates, latent interactions, and many more. Previously, these were either only available in commercial software, or required knowledge of probabilistic programming software. 


3. Nehler, K. J. (2026). mantar: Missingness Alleviation for Network Analysis. R package version 0.2.0 [https://doi.org/10.32614/CRAN.package.mantar](https://doi.org/10.32614/CRAN.package.mantar)

    * The newly released `mantar` implements cross-sectional network estimation methods that are sometimes preferable to standard glasso regularization, including nonconvex atan regularization and neighborhood selection.
    * A key strength of `mantar` is its explicit focus on missing data, offering both a two-step EM approach and stacked multiple imputation. Stacked MI is not available in bootnet, but is particularly useful when multiple analyses are planned and consistent missing data handling is required.
    * `mantar` functionality is also implemented in the `bootnet` package, allowing users to easily handle missing values and at the same time use their preferred network estimation method and perform stability analysis.

4. Berkhout, S. W., Schuurman, N. K., Niemeijer, K., Kuppens, P. & Hamaker, E.L. (2025). Dynamics Between Asynchronously Measured Variables: A Multilevel Approach to Momentary Affect and Morning Sleep Reports, Multivariate Behavioral Research, [https://doi.org/10.1080/00273171.2025.2551370](https://doi.org/10.1080/00273171.2025.2551370)

    * Many experience sampling studies contain variables measured at different time intervals. A prime example is the measurement of affect (multiple times per day) and sleep (which usually is only assessed once per day).
    * While the relation between such variables is often of great theoretical interest, modeling these different sampling frequencies is difficult in standard models. 
    * The authors introduce a dynamic structural equation model that handles relations between affect and daily measures of sleep. They also provide guidance on how their model could be adapted to other variables measured at different frequencies. 


## Newsletter 2025-02

In this newsletter, we are presenting papers on (1) the handling of missing data in cross-sectional networks, (2) dealing with overnight effects in longitudinal models, (3) network comparison in panel and time series data, and (4) confirmatory network estimation. Finally, we introduce you to (5) an open-source, wiki-style resource collecting long-form blogposts and information about experience sampling and time series modeling. 


1. Nehler, K. J., & Schultze, M. (2025). Missing Data Handling via EM and Multiple Imputation in Network Analysis using Glasso and Atan Regularization. Multivariate Behavioral Research, 1–23. [https://doi.org/10.1080/00273171.2025.2503833](https://doi.org/10.1080/00273171.2025.2503833)

    * Missing data are common in psychological datasets, including cross-sectional ones. However, there is no consistent standard for handling missingness across different network estimation methods.
    * We evaluated modern missing data approaches based on maximum likelihood and multiple imputation. Deletion methods were not considered, as prior research has already shown them to be suboptimal and they should not be used. 
    * Stacked multiple imputation (using mice along with some additional manual steps) performed well across all sample sizes and two network estimation techniques. In contrast, the two-step EM algorithm (as implemented in bootnet via "fiml") only performed well with very large sample sizes.
    * Implementation is available in the R package [`mantar`](https://cran.r-project.org/web/packages/mantar/index.html).

2. Berkhout, S. W., Schuurman, N. K., & Hamaker, E. L. (2025). Let sleeping dogs lie? How to deal with the night gap problem in experience sampling method data. Psychological Methods. Advance online publication. [https://doi.org/10.1037/met0000762](https://doi.org/10.1037/met0000762)

    * Experience sampling researchers are often interested in lagged effects between variables, that is, how one variables (such as stress) affects another one (such as negative affect) at the next time point. However, not all lags are equal: The effect from the last evening timepoint of a day to the next morning timepoint is fundamentally different compared to a lagged effect between two timepoints during the day.
    * Commonly, researchers either ignore this issue, which leads to an issue in interpreting these models, or they remove this effect from their modeling approach, which leads to fewer effectively usable datapoints in a study and disregards potentially interesting overnight effects. In their paper, Berkhout et al. discuss all potential options of dealing with night effects and provide estimation code for these different approaches.
    * Their paper provides a nice example of a modeling decision that seems like a nuisance, but that actually has profound theoretical influence on the interpretation of lagged estimates from your study.

3. Du, X., Johnson, S. U., & Epskamp, S. (2025). The Invariance Partial Pruning Approach to The Network Comparison in Time-Series and Panel Data. [https://doi.org/10.31234/osf.io/vb8dz_v1](https://doi.org/10.31234/osf.io/vb8dz_v1)

    * Researchers are often interested in comparing dynamic networks within individuals over time, or between individuals in a sample. Such comparisons can be informative, for instance, shedding light on heterogeneity or helping to understand how people with different psychopathologies differ in their network structures. The authors introduce a novel method that can determine whether dynamic networks differ and, if so, in which areas.
    * The test is conceptually similar to model comparison tests in structural equation modeling or item response theory, but was adapted to fit the needs of network researchers.
    * This novel methodology is a potential improvement over existing comparison tests for individual networks by Hoekstra et al. (2024, [https://doi.org/10.1037/met0000638](https://doi.org/10.1037/met0000638)), Siepe et al. (2024, [https://psycnet.apa.org/doi/10.1037/met0000672](https://psycnet.apa.org/doi/10.1037/met0000672)), and Haslbeck (2025, [https://cran.r-project.org/web/packages/mnet/index.html](https://cran.r-project.org/web/packages/mnet/index.html)). The authors also provide an R package that allows for a user-friendly implementation of the test.

 4. Du, X., Skjerdingstad, N., Freichel, R., Ebrahimi, O. V., Hoekstra, R. H. A., & Epskamp, S. (2025). Moving from exploratory to confirmatory network analysis: An evaluation of structural equation modeling fit indices and cutoff values in network psychometrics. Psychological Methods. [https://doi.org/10.1037/met0000760](https://doi.org/10.1037/met0000760)

    * The growing body of exploratory findings in network studies highlights the need for confirmatory analyses to test hypotheses and assess replicability. In longitudinal settings, exploratory models can also be seen as semi-confirmatory, as they rely on the often-overlooked assumption of stationarity without explicitly testing it.
    * The authors show that fit indices from the SEM literature are sensitive to misspecified network structures and violations of stationarity. While conventional cutoffs perform reasonably well, stricter thresholds may be needed for hypothesis testing and replication.
    * The Shiny app allows users to explore the results interactively and to examine the rejection rates associated with cutoff values of their own choice.

5. [MATILDA Resource](https://matilda.fss.uu.nl/)

    * Researchers at Utrecht University, which is well-known for its strong and diverse quantitative psychology department, have created the website MATILDA ("Measurement, Analysis & Theory for Intensive Longitudinal Data"). The website contains a growing selection of peer-reviewed educational articles designed to be useful for applied researchers working with intensive longitudinal data.
    * This community-based resource especially focuses on theoretical considerations, such as the importance of floor effects or different time scales for the interpretation of study findings.


## Newsletter 2025-01

In this newsletter, we present you with papers on power and quality assessment (1), subgrouping dynamic networks (2), issues and solutions for using network centrality/density for treatment selection and outcome prediction (3), and a review of the use of ecological momentary assessment in psychotherapy research (4).

1. Zhang, Y., Revol, J., Lafit, G., Ernst, A. F., Razum, J., Ceulemans, E., & Bringmann, L. F. (2025). Meeting the Bare Minimum: Quality Assessment of Idiographic Temporal Networks Using Power Analysis and Predictive Accuracy Analysis. PsyArXiv. [https://doi.org/10.31219/osf.io/73qw9_v1](https://doi.org/10.31219/osf.io/73qw9_v1)

    * Idiographic networks (that is, networks estimated on time series data of a single individual) often likely do not provide good fit to empirical data, but this is rarely assessed. Relatedly, sample size planning for the number of timepoints to achieve a certain power is usually not performed in idiographic networks.
    * They introduce a) power analysis and b) predictive accuracy analysis to a) a priori inform the number of timepoints that need to be collected and b) post-hoc evaluate if the number of time points was sufficient in a given application.
    * In a reanalysis of existing empirical studies, they find that most previous idiographic networks were likely underpowered and overfitted empirical data.

2. Ernst A. F. & Haslbeck J. M. B. (2025). Modeling Qualitative Between-Person Heterogeneity in Time-Series using Latent Class Vector Autoregressive Models. PsyArXiv. [https://osf.io/preprints/psyarxiv/qvdac_v1](https://osf.io/preprints/psyarxiv/qvdac_v1) 

    * It is often theoretically and statistically plausible that there are distinct subgroups of individuals in a sample with similar dynamic network characteristics. Previously,  Group Iterative Multiple Model Estimation ([`GIMME`](https://cran.r-project.org/web/packages/gimme/vignettes/gimme_vignette.html)) was primarily used to enable subgrouping. This method comes with some downsides, such as the use of relatively arbitrary cutoff criteria to find subgroups.
    * The authors provide a tutorial on latent class VAR models, which enables modeling different qualitatively different clusters that differ in they dynamic relationships. In their empirical illustration, they cluster individuals based on their emotion dynamics
    * The methods presented in the paper are available in the [`ClusterVAR` package](https://cran.r-project.org/web/packages/ClusterVAR/index.html).

3. Siepe, B. S., Kloft, M., Zhang, Y., Petersen, F., Bringmann, L. F., & Heck, D. W. (2025). Using features of dynamic networks to guide treatment selection and outcome prediction: The central role of uncertainty. PsyArXiv. [https://doi.org/10.31234/osf.io/2c8xf_v1](https://doi.org/10.31234/osf.io/2c8xf_v1)

    * There are two main ways in which dynamic networks can be useful to change mental health treatments: Either by being directly used in therapy as a feedback tool, or by using abstractions of a network such as centrality indices, controllability or network density (i.e., network features) to select personalized treatments or to predict certain outcomes. This paper deals with issues and potential solutions to the latter aim.
    * Previous research has suggested using: The most central node as an aim for treatment or network features as predictors of an outcome, such as psychopathology. However: We know little about the accuracy of centrality estimation and the uncertainty of centrality estimates is commonly ignored.
    * The authors introduce a new Bayesian approach to multilevel vector autoregression (BmlVAR) that enables accurate uncertainty quantification and often better results in relating network centality to an outcome.
    * There are many statistical hurdles to using network features in practice, and the authors provide a novel method and some recommendations for dealing with them.

4. Mink, F., Lutz, W., & Hehlmann, M. I. (2025). Ecological momentary assessment in psychotherapy research: A systematic review. Clinical Psychology Review, 102565. [https://doi.org/10.1016/j.cpr.2025.102565](https://doi.org/10.1016/j.cpr.2025.102565)

    * There is a lot of interest in using EMA/ESM in psychotherapy research to describe, understand, and predict processes or outcomes of interest.
    * The authors reviewed 168 studies on the topic and showed six main areas of clinical utilization of EMA: prediction of therapy outcome ($n = 8$), prediction of psychopathology ($n = 40$), prediction of biopsychosocial states ($n = 44$), evaluation of therapy outcome ($n = 21$), acquisition of further clinical insights into specific disorders ($n = 68$) and adaptation of treatment processes (n = 18).
    * Despite often being advocated as a potential way to personalize psychotherapy treatment, EMA has mostly been used for descriptive and predictive purposes so far.
    * Good news for all researchers interested in the topic: There is still much to be done!
