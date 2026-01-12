---
title: "Cross-sectional Networks" 
type: post
date: '2025-12-22'
slug: cross-sectional-network-design
categories: ["DYNAMIC"] 
tags: [] 
subtitle: ''
summary: 'This page contains a collection of frequently asked questions concerning psychological network analysis in cross-sectional settings. The questions were collected as part of the methodological consultation within the DYNAMIC project.' 
authors: [] 
weight: 1
lastmod: "2025-12-29"
featured: no
banner: 
  image: "/header/node_junctions.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/724752)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /extras/dynamic/cross-sectional-network-design
  # - icon_pack: fas
  #   icon: terminal
  #   name: Code
  #   url: /extras/dynamic/cross-sectional-design.R
output:
  html_document:
    keep_md: true
---






## How should researchers decide which psychological constructs to examine and which variables to include as nodes in a network?

Psychological network models are based on the idea that one should not assume latent variables a priori, but instead focus on the direct relationships between observed variables (Borsboom & Cramer, 2013). This perspective partly emerged as a response to the difficulty of identifying indicators that cleanly reflect a single latent construct, particularly in clinical psychology. In such contexts, items often show cross-loadings or shared variance beyond a single latent factor, and network approaches aim to make these unique relationships between observed variables the central object of analysis. Consequently, investigating a construct within a network framework is most informative when the construct is not strictly unidimensional. For constructs that are well described by a single latent factor, latent variable models are often more appropriate, and network models - at least in my experience - may additionally suffer from estimation and stability issues.

When selecting items, symptoms, or traits for a psychological network, it is important to keep in mind that edge weights typically represent partial correlations, that is, associations between two nodes while controlling for all other nodes in the network (Epskamp, Borsboom & Fried, 2017). Node selection is therefore a fundamentally theory-driven process (Borsboom et al., 2021). This leads to the recommendation to focus on constructs with clearly defined theoretical components and to include all of these components as nodes in the network (for example, all core symptoms of depression). Selectively excluding theoretically relevant components should be avoided, as this alters the set of variables on which conditional associations are estimated and can thereby change the resulting network structure. Furthermore, multiple indicators of the same component (e.g., two items measuring anhedonia) should not be included, as they can distort the estimated network structure; this recommendation is based on concerns about strongly overlapping nodes (Christensen et al., 2023).


Beyond the use of single items or symptoms as nodes, there is a growing trend to include construct-level variables in psychological networks, resulting in the inclusion of variables at different levels of abstraction (Briganti et al., 2024). This practice requires careful consideration, as it departs from the core idea of partial correlation networks, which aim to model direct relationships between observed variables. Nevertheless, the inclusion of construct-level variables can be meaningful when these constructs are reasonably unidimensional and are analyzed alongside more complex constructs that are represented at the item level. For example, a composite measure of fluid intelligence may be included in a symptom-level depression network, where the latter reflects a more heterogeneous and complex structure. Another motivation for using construct-level scores is to reduce the number of nodes in situations where network estimation becomes challenging (e.g., Carpi et al., 2025). Such decisions require particular caution, however, as aggregating variables can substantially alter the network topology. Accordingly, the chosen level of abstraction should be closely aligned with the research question at hand (Briganti et al., 2024).

Recent methodological advances have proposed integrated frameworks that combine latent variable and network models (Wang, 2021). Prominent examples include latent network modeling and residual network modeling, which allow conditional independence relationships among latent variables or among residuals to be examined within a unified psychometric framework (Epskamp, Rhemtulla, & Borsboom, 2017).

Regardless of the specific choices, it is crucial to clearly justify them and to report these decision transparently.

## How should researchers choose an estimation method for network analysis?

This is one of the most central questions in psychological network analysis, as reflected by a dedicated review paper addressing this issue directly (Isvoranu & Epskamp, 2021). Below, we provide a brief summary of the key points from this review, supplemented with insights from more recent methodological developments.

Early work on psychological networks primarily relied on the *graphical lasso* (glasso; Friedman et al., 2008) as the default estimation method (Williams et al., 2020), largely because it was already well established in network research in other disciplines. However, it should not be regarded as the default choice, as it was originally developed for settings in which the number of observations is smaller than the number of variables (Friedman et al., 2008), a situation that is not typical for most psychological applications (Wysocki & Rhemtulla, 2021).

The paper by Isvoranu and Epskamp (2021) provides guidance on which estimation methods are appropriate under different conditions and includes code for a Shiny application that can be run locally to support this decision process. The investigated approaches are primarily implemented in the CRAN packages [bootnet](https://cran.r-project.org/web/packages/bootnet/index.html) and [BGGM](https://cran.r-project.org/web/packages/BGGM/index.html), respectively. Since the publication of this review, additional estimation approaches have been proposed. Among the most promising developments are methods based on nonconvex regularization (Williams, 2020), in particular those using the *atan* penalty. At present, this approach is available on CRAN only through the [mantar](https://cran.r-project.org/web/packages/mantar/index.html) package.


## Which data characteristics should be considered when estimating a psychological network?

### Measurement level of the variables

Most standard implementations of psychological network estimation are based on Pearson correlations and therefore implicitly assume continuous data. For ordered categorical variables, simulation studies have shown that using Pearson correlations can still perform well in practice (Johal & Rhemtulla, 2023), and in some cases even comparably or better than approaches specifically designed for ordinal data (Isvoranu & Epskamp, 2021). 

From a theoretical perspective, treating ordinal variables as continuous is expected to be reasonable primarily when the variables have a sufficiently large number of categories (e.g., five or more) and when category distributions are not strongly skewed (Rhemtulla et al., 2012). When these conditions are not met, the use of polychoric correlations is theoretically recommended (Foldnes & Grønneberg, 2022). As noted above, simulation studies in the context of network analysis have not consistently demonstrated superior performance of polychoric correlations compared to Pearson correlations. One possible explanation is that polychoric correlations typically require larger sample sizes to be estimated reliably. Moreover, from a theoretical perspective currently investigated in ongoing research, discretizing underlying continuous variables may fundamentally limit the recoverability of the true network structure, even with very large sample sizes.

In addition, polychoric correlations rely on the assumption of an underlying continuous, normally distributed variable (Foldness & Grønneberg, 2022). When this assumption is violated, for example, if the latent distribution is substantially skewed, Pearson correlations may, in practice, introduce less estimation error than polychoric correlations. In such cases, neither approach is expected to fully recover the true underlying model, even at large sample sizes.

In summary, using Pearson correlations may be a reasonable choice for ordinal data with approximately symmetric distributions and a sufficient number of categories. In these cases, one could also compute the network once using polychoric correlations and once using Pearson correlations; if there is a large difference, the interpretation of the results should be made with caution. Polychoric correlations should theoretically be preferable when these conditions are not met, albeit with important practical and theoretical caveats.

For binary data, the Ising model provides a dedicated network modeling framework that is specifically designed for dichotomous variables (van Borkulo et al., 2014). In psychological network research, the Ising model has been widely used for symptom presence vs. absence data and is implemented, for example, in the R package [IsingFit](https://cran.r-project.org/web/packages/IsingFit/index.html).

For more complex data structures involving mixed variable types, such as continuous (Gaussian), count (Poisson), and categorical variables, mixed graphical models (MGMs) offer a flexible alternative (Haslbeck & Waldorp, 2020). These models allow different types of variables to be included simultaneously within a single network and are implemented in the R package [mgm](https://cran.r-project.org/web/packages/mgm/index.html).

### Floor or ceiling effects

How to handle the data when distributions are not only skewed but show clear ceiling or, more prominently, floor effects remains an open question. There is currently little methodological research on this topic in the context of psychological network analysis. Approaches such as zero-inflated or hurdle models, which are commonly used in other types of analyses when a large number of zeros is present, are not available in psychological network estimation. While related methods exist in the bioinformatics literature (e.g., Choi et al., 2017; Park et al., 2021), they focus on the presence or absence of edges, whereas psychological network analysis is usually concerned with the estimation of edge strength. Moreover, these approaches are sometimes not implemented in readily available software.

One approach that has been used in practice is to transform the original data into a binary format and to estimate the network using an Ising model (e.g., Mullarkey et al., 2019). As with any transformation of variables, this procedure entails a loss of information and should therefore only be applied when there is a clear theoretical justification. In particular, it is crucial that the chosen cutoff is meaningful. For example, this may be the case when items clearly distinguish between individuals who experience a symptom and those who do not experience it at all, or when a questionnaire manual explicitly defines categories that correspond to a clinically relevant severity threshold versus non-clinical levels.

### Missing data

Again, there is relatively little methodological research on this topic in the context of psychological networks. However, it has been shown that missing values should not be handled via listwise or pairwise deletion (Nehler & Schultze, 2024), which is not surprising given that such approaches are well known to produce biased estimates when data are not missing completely at random (Enders, 2010).


For some estimation methods, more systematic research on missing data handling is available. Among the approaches shown to perform particularly well are the two-step expectation–maximization (EM) algorithm and stacked multiple imputation (MI). The two-step EM approach first uses an EM algorithm to estimate the correlation matrix via an EM algorithm and then estimates the network based on this matrix. In stacked MI, $m$ complete data sets are imputed, they are stacked into one big data set and the corresponding correlation matrix is computed, and the network is estimated using this matrix. These approaches have been evaluated in combination with the glasso as a convex regularization method and the atan penalty as a nonconvex regularization approach (Nehler & Schultze, 2025), as well as neighborhood selection using the Bayesian Information Criterion (BIC). Accordingly, one may assume that these approaches are well suited for estimation procedures that are based on correlation or covariance matrices and do not require access to the raw data. While both approaches perform well, simulation results suggest that stacked multiple imputation is generally preferable. Only in situations where the number of observations is large relative to the number of variables does the two-step EM approach show comparable or superior performance.


From a practical standpoint, the two-step EM approach is easier to apply, as it is implemented in the [bootnet](https://cran.r-project.org/web/packages/bootnet/index.html) package and can therefore be readily combined with stability analyses (see below). In contrast, stacked multiple imputation is currently implemented only in the [mantar](https://cran.r-project.org/web/packages/mantar/index.html) package and, when combined with stability testing, can be computationally intensive. A general advantage of multiple imputation, however, is that additional analyses can be conducted on the imputed data sets as well, allowing for a consistent handling of missing data across the entire analysis (Enders, 2010). Researchers interested in using stacked multiple imputation are encouraged to contact the DYNAMIC methods consultation or reach out directly for further guidance.

## What network indices should be used and how should their stability be assessed?

From a descriptive perspective, psychological networks offer three main types of indices:

- Edge weights: These quantify the strength of the relationships between pairs of nodes and represent conditional associations given all other nodes in the network.
- Centrality indices: These reflect the relative importance of nodes within the network, for example by capturing how many connections a node has and how strong these connections are. Relatedly, centrality measures are often linked to node *predictability*, which indicates how well a node can be predicted by all other nodes in the network.
- Community structure: This refers to the presence of groups or clusters of nodes that are more strongly connected to each other than to the rest of the network, potentially indicating meaningful substructures within the network.

Edge weights, or, more fundamentally, the presence or absence of edges, form the cornerstone of network analysis and underlie all other network indices. The reliability of edge estimates can be improved by choosing appropriate estimation methods, as discussed in the previous sections. In addition, the stability of edge weights should be assessed using nonparametric bootstrapping (Epskamp, Borsboom & Fried, 2017), for example as implemented in the [bootnet](https://cran.r-project.org/web/packages/bootnet/index.html) package. Beyond evaluating stability by inspecting the variability of edge weights across bootstrap samples, researchers can also examine differences between edge weights. This is commonly done by assessing whether the bootstrap intervals of two edges overlap, providing an indication of whether the strengths of two edges can be meaningfully distinguished.

Centrality indices (e.g., Opsahl et al., 2010) were already used in early psychological network studies, largely following practices established in network research in other fields. Therefore, commonly used indices included node strength (the sum of the absolute edge weights connected to a node), closeness (the average distance of a node to all other nodes in the network), and betweenness (the extent to which a node lies on the shortest paths between other nodes).

However, several simulation studies have demonstrated that some of these indices pose problems in psychological networks. In particular, closeness and betweenness centrality have been shown to be unstable and unreliable under typical conditions encountered in psychological data (e.g., Epskamp, Borsboom, & Fried, 2017). In addition, it has been questioned whether these indices are theoretically meaningful for psychological processes at all, for example, whether psychological processes can reasonably be assumed to operate via mechanisms analogous to shortest paths in a network (Bringmann et al., 2019). As a result, it is generally recommended to focus on strength centrality when interpreting psychological networks, or on degree in the case of unweighted networks. An alternative to strength is expected influence, which takes the sign of edge weights into account and has been shown to be particularly informative in networks that include negative edges.

In addition, bridge strength can be used to identify nodes that are strongly connected to nodes belonging to other constructs, thereby highlighting variables that may link different parts of the network. The R packages [qgraph](https://cran.r-project.org/web/packages/qgraph/index.html) and [networktools](https://cran.r-project.org/web/packages/networktools/index.html) provide implementations of these centrality measures, including some variants that distinguish between incoming and outgoing connections. For cross-sectional networks, however, this distinction is not relevant, as all edges are undirected.

Again, the stability of centrality indices should be assessed using case-dropping bootstrap procedures, for example as implemented in the [bootnet](https://cran.r-project.org/web/packages/bootnet/index.html) package. Centrality indices should only be interpreted if they show sufficient stability, commonly quantified using the correlation stability coefficient, with values of at least .5 recommended (Epskamp, Borsboom, & Fried, 2017).

While edge weights and centrality indices are standard components of psychological network analysis, the investigation of clustering is used less frequently, as clusters are often theoretically expected a priori and therefore not the primary focus of the research question. Nevertheless, there are applications that report clustering-related measures in psychological networks (e.g., Landvreugd et al., 2024). Two types of clustering coefficients are commonly distinguished: global and local clustering coefficients. Global clustering coefficients quantify the overall tendency of nodes in a network to form clusters, whereas local clustering coefficients assess this tendency at the level of individual nodes. Both types of coefficients can be computed using implementations available in the R package [qgraph](https://cran.r-project.org/web/packages/qgraph/index.html). The appropriate definition and interpretation of clustering coefficients depend on whether the network is weighted and on whether edge weights can take both positive and negative values. To the best of my knowledge, there is currently no methodological work that describes stability analysis for the computed clustering coefficients in psychological network analysis, as is done for the centrality statistics with the [bootnet](https://cran.r-project.org/web/packages/bootnet/index.html) package.


## What inferential methods are available for cross-sectional networks?

Psychological network analysis was initially developed and primarily used as an exploratory tool. Early applications focused on describing network structures using indices such as edge weights and centrality measures, as well as visualizing networks to gain an intuitive understanding of the relationships between variables. In this sense, network analysis has often been used for descriptive purposes or as a hypothesis-generating approach (Hevey, 2018). 

At the same time, from early on there was the theoretical assumption that network structures should differ between groups of individuals (Borsboom, 2017), for example between people with and without a mental disorder, or between different clinical subgroups. In response to this motivation, several methodological papers have been written to lay the foundation for moving beyond purely descriptive analyses toward formal hypothesis testing in psychological networks. 

One prominent example is the Network Comparison Test (NCT), a permutation based procedure that allows researchers to formally test whether two networks differ from each other (van Borkulo et al., 2023). It can be used to assess differences in global network strength, overall structure, or specific edge weights between groups (e.g., clinical vs. non-clinical samples). The NCT is widely used in psychological network research and is implemented in the R package [NetworkComparisonTest](https://cran.r-project.org/web/packages/NetworkComparisonTest/index.html).

Beyond between network comparisons, confirmatory network analysis also requires tools to evaluate the fit of a hypothesized network structure, analogous to model fit indices in the structural equation modeling literature. Du et al. (2025) demonstrated that conventional SEM fit indices can be meaningfully applied to network models, although stricter cutoff values may be preferable in certain settings.

# References

Borsboom, D. (2017). A network theory of mental disorders. *World psychiatry, 16*(1), 5-13. [https://doi.org/10.1002/wps.20375](https://doi.org/10.1002/wps.20375)

Borsboom, D., & Cramer, A. O. (2013). Network analysis: an integrative approach to the structure of psychopathology. *Annual review of clinical psychology, 9*(1), 91-121. [https://doi.org/10.1146/annurev-clinpsy-050212-185608](https://doi.org/10.1146/annurev-clinpsy-050212-185608)

Borsboom, D., Deserno, M. K., Rhemtulla, M., Epskamp, S., Fried, E. I., McNally, R. J., ... & Waldorp, L. J. (2021). Network analysis of multivariate data in psychological science. *Nature Reviews Methods Primers, 1*(1), 58. [https://doi.org/10.1038/s43586-021-00055-w](https://doi.org/10.1038/s43586-021-00055-w)

Briganti, G., Scutari, M., Epskamp, S., Borsboom, D., Hoekstra, R. H., Golino, H. F., ... & McNally, R. J. (2024). Network analysis: An overview for mental health research. *International Journal of Methods in Psychiatric Research, 33*(4), e2034. [https://doi.org/10.1002/mpr.2034](https://doi.org/10.1002/mpr.2034)

Bringmann, L. F., Elmer, T., Epskamp, S., Krause, R. W., Schoch, D., Wichers, M., Wigman, J. T. W., & Snippe, E. (2019). What do centrality measures measure in psychological networks? *Journal of Abnormal Psychology, 128*(8), 892–903. [https://doi.org/10.1037/abn0000446](https://doi.org/10.1037/abn0000446)

Carpi, M., Marques, D. R., & Liguori, C. (2025). Unraveling the insomnia web: a network analysis of insomnia and psychological symptoms in good and poor sleepers among young adults. *Sleep Medicine*, 106590. [https://doi.org/10.1016/j.sleep.2025.106590](https://doi.org/10.1016/j.sleep.2025.106590)

Choi, H., Gim, J., Won, S., Kim, Y. J., Kwon, S., & Park, C. (2017). Network analysis for count data with excess zeros. *BMC genetics, 18*(1), 93. [https://doi.org/10.1186/s12863-017-0561-z](https://doi.org/10.1186/s12863-017-0561-z)

Christensen, A. P., Garrido, L. E., & Golino, H. (2023). Unique variable analysis: A network psychometrics method to detect local dependence. *Multivariate Behavioral Research, 58*(6), 1165-1182. [https://doi.org/10.1080/00273171.2023.2194606](https://doi.org/10.1080/00273171.2023.2194606)

Du, X., Skjerdingstad, N., Freichel, R., Ebrahimi, O. V., Hoekstra, R. H., & Epskamp, S. (2025). Moving from exploratory to confirmatory network analysis: An evaluation of structural equation modeling fit indices and cutoff values in network psychometrics. Psychological Methods. [https://psycnet.apa.org/doi/10.1037/met0000760](https://psycnet.apa.org/doi/10.1037/met0000760)

Enders, C. K. (2010). *Applied Missing Data Analysis*. Guilford Press.

Epskamp, S., Borsboom, D., & Fried, E. I. (2017). Estimating psychological networks and their accuracy: A tutorial paper. *Behavior research methods, 50*(1), 195-212. [https://doi.org/10.3758/s13428-017-0862-1](https://doi.org/10.3758/s13428-017-0862-1)

Epskamp, S., Rhemtulla, M., & Borsboom, D. (2017). Generalized network psychometrics: Combining network and latent variable models. Psychometrika, 82(4), 904-927. [https://doi.org/10.1007/s11336-017-9557-x](https://doi.org/10.1007/s11336-017-9557-x)

Foldnes, N. & Grønneberg, S. (2022). The sensitivity of structural equation modeling with ordinal data to underlying non-normality and observed distributional forms. *Psychological Methods, 27*(4), 541–567. [https://doi.org/10.1037/met0000385](https://doi.org/10.1037/met0000385)

Friedman, J., Hastie, T., & Tibshirani, R. (2008). Sparse inverse covariance estimation with the graphical lasso. *Biostatistics, 9*(3), 432-441. [https://doi.org/10.1093/biostatistics/kxm045](https://doi.org/10.1093/biostatistics/kxm045)

Haslbeck, J. M., & Waldorp, L. J. (2020). mgm: Estimating time-varying mixed graphical models in high-dimensional data. *Journal of Statistical Software, 93*, 1-46. [https://doi.org/10.18637/jss.v093.i08](https://doi.org/10.18637/jss.v093.i08)


Hevey, D. (2018). Network analysis: a brief overview and tutorial. *Health psychology and behavioral medicine, 6*(1), 301-328. [https://doi.org/10.1080/21642850.2018.1521283](https://doi.org/10.1080/21642850.2018.1521283)

Isvoranu, A. M., & Epskamp, S. (2023). Which estimation method to choose in network psychometrics? Deriving guidelines for applied researchers. Psychological methods, 28(4), 925-946. [https://doi.org/10.1037/met0000439](https://doi.org/10.1037/met0000439)

Johal, S., & Rhemtulla, M. (2023). A comparison of methods for estimating psychological networks with ordinal data. *Psychological Methods, 28*(6), 1251-1272. [https://doi.org/10.1037/met0000449](https://doi.org/10.1037/met0000449)

Landvreugd, A., van de Weijer, M. P., Pelt, D. H., & Bartels, M. (2024). Connecting the dots: using a network approach to study the wellbeing spectrum. *Current Psychology, 43*(34), 27365-27376. [https://doi.org/10.1007/s12144-024-06363-0](https://doi.org/10.1007/s12144-024-06363-0)

Mullarkey, M. C., Marchetti, I., & Beevers, C. G. (2019). Using network analysis to identify central symptoms of adolescent depression. *Journal of Clinical Child & Adolescent Psychology, 48*(4), 656-668. [https://doi.org/10.1080/15374416.2018.1437735](https://doi.org/10.1080/15374416.2018.1437735)

Nehler, K. J., & Schultze, M. (2024). Simulation-Based Performance Evaluation of Missing Data Handling in Network Analysis. *Multivariate Behavioral Research, 59*(3), 461–481. [https://doi.org/10.1080/00273171.2023.2283638](https://doi.org/10.1080/00273171.2023.2283638)

Opsahl, T., Agneessens, F., & Skvoretz, J. (2010). Node centrality in weighted networks: Generalizing degree and shortest paths. *Social Networks, 32*(3), 245–251. [https://doi.org/10.1016/j.socnet.2010.03.006](https://doi.org/10.1016/j.socnet.2010.03.006)

Park, B., Choi, H., & Park, C. (2021). Negative binomial graphical model with excess zeros. *Statistical Analysis and Data Mining: The ASA Data Science Journal, 14*(5), 449-465. [https://doi.org/10.1002/sam.11536](https://doi.org/10.1002/sam.11536)

Van Borkulo, C. D., Borsboom, D., Epskamp, S., Blanken, T. F., Boschloo, L., Schoevers, R. A., & Waldorp, L. J. (2014). A new method for constructing networks from binary data. *Scientific reports, 4*(1), 5918. [https://doi.org/10.1038/srep05918](https://doi.org/10.1038/srep05918)

Van Borkulo, C. D., van Bork, R., Boschloo, L., Kossakowski, J. J., Tio, P., Schoevers, R. A., ... & Waldorp, L. J. (2023). Comparing network structures on three aspects: A permutation test. Psychological methods, 28(6), 1273-1285. [https://psycnet.apa.org/doi/10.1037/met0000476](https://psycnet.apa.org/doi/10.1037/met0000476)

Wang, S. (2021). Recent integrations of latent variable network modeling with psychometric models. *Frontiers in psychology, 12*, 773289. [https://doi.org/10.3389/fpsyg.2021.773289](https://doi.org/10.3389/fpsyg.2021.773289)

Williams, D. R. (2020). Beyond lasso: A survey of nonconvex regularization in Gaussian graphical models. [https://doi.org/10.31234/osf.io/ad57p](https://doi.org/10.31234/osf.io/ad57p)

Williams, D. R., Rhemtulla, M., Wysocki, A. C., & Rast, P. (2019). On nonregularized estimation of psychological networks. *Multivariate behavioral research, 54*(5), 719-750. [https://doi.org/10.1080/00273171.2019.1575716](https://doi.org/10.1080/00273171.2019.1575716)

Wysocki, A. C., & Rhemtulla, M. (2021). On penalty parameter selection for estimating network models. *Multivariate behavioral research, 56*(2), 288-302. [https://doi.org/10.1080/00273171.2019.1672516](https://doi.org/10.1080/00273171.2019.1672516)
