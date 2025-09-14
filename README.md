
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pcsurvey

<!-- badges: start -->

[![R-CMD-check](https://github.com/pachaloh/pcsurvey/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachaloh/pcsurvey/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The pcsurvey package provide a list of tools to perform some common
survey related statistical operations, including sampling clusters
within strata with proportional to size, systematic sampling of units
within a cluster, deleting empty columns and working on duplicates.

## Installation

You can install the development version of pcsurvey from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("pachaloh/pcsurvey")
```

## How to use

To use the functions contained within, load the pcsurvey package first.

``` r
library(pcsurvey)
```

### sampling with proportional to size

If interest is to sample units, say clusters, proportional to their
sizes, from strata, use
[pc_pps_survey()](https://pachaloh.github.io/pcsurvey/reference/pc_pps_survey.html)
function. Regardless of your geographical setup or data structure,
organize your data frame of primary units to have these three columns:

- stratum, that specifies strata from which the primary units is
- cluster, that identifies the primary units and
- cluster_pop that contains corresponding sizes of each primary unit
  (cluster).

Here is a basic example which demonstrates usage of the package
function:

``` r
set.seed(1000)
stratum = rep(c(1,2),c(30,50))
cluster <- c(1:30,1:50)
cluster_pop <- sample(365:1309,80,replace=TRUE)
sample_frame <- data.frame(stratum,cluster, cluster_pop)

sample <- pc_pps_survey(sample_frame,10)
sample <- pc_pps_survey(sample_frame,nsize = c(10,7))
```

### Systematic sampling

If, however, interest is just to sample units using systematic random
sampling,
[pc_sample_hh_survey()](https://pachaloh.github.io/pcsurvey/reference/pc_sample_hh_survey.html)
function comes in handy. This is more applicable when sampling, say,
households from clusters. The data frame must contain a “cluster” column
that identifies a cluster the units (households) belong to. The same
number of units is sampled from each cluster.

``` r
set.seed(1000)
cluster = rep(c(1,2),c(30,50))
hhno <- c(1:30,1:50)
sample_frame <- data.frame(cluster,hhno)

sample <- pc_sample_hh_survey(sample_frame,10)
```

## Future updates
