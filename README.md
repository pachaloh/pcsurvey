
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pcsurvey

<!-- badges: start -->

[![R-CMD-check](https://github.com/pachaloh/pcsurvey/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachaloh/pcsurvey/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of pcsurvey is to perform some sampling with ease. There are
currently two functions that sample cases with proportion to size of
stratum (pc_pps_survey), and sample same number of cases from ea_code
(pc_sample_hh_survey).

## Installation

You can install the development version of pcsurvey from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("pachaloh/pcsurvey")
```

## How to use

For the functions to work properly, your data must be structured in a
specific format.

If you plan to select enumeration areas or clusters within a stratum
proportional to their sizes, use pc_pps_survey() function. Your data
frame must contain stratum, cluster and cluster_pop columns

## Example

Here are basic examples which demonstrates usage of the package:

``` r
library(pcsurvey)
set.seed(1000)
stratum = rep(c(1,2),c(30,50))
cluster <- c(1:30,1:50)
cluster_pop <- sample(365:1309,80,replace=TRUE)
sample_frame <- data.frame(stratum,cluster, cluster_pop)
sample <- pc_pps_survey(sample_frame,10)
sample <- pc_pps_survey(sample_frame,nsize = c(10,7))
```
