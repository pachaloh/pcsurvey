
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pcsurvey

<!-- badges: start -->

[![R-CMD-check](https://github.com/pachaloh/pcsurvey/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachaloh/pcsurvey/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The pcsurvey package provide a list of tools to perform some survey
operations. With these tools, you would sample units from a population,
delete empty columns and work on duplicates.

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

If interest is to sample units proportional to their sizes, use
[pc_pps_survey()](https://pachaloh.github.io/pcsurvey/reference/pc_pps_survey.html)
function. For example, your task would be to sample enumerations
areas(EAs) within districts. With this setup, the primary sampling unit
becomes the EA, and district becomes your stratum. For the function to
work properly, your data frame of primary units must have three columns:

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

If, however, interest is to sample same number of cases in and area, use
pc_sample_hh_survey() function. This is more applicable when sampling
households within an enumeration area. The area to sample from, must be
named “ea_code”. The function samples the same number of cases from each
ea_code. By default, it samples 20 cases.

``` r
set.seed(1000)
ea_code = rep(c(1,2),c(30,50))
hhno <- c(1:30,1:50)
sample_frame <- data.frame(ea_code,hhno)

sample <- pc_sample_hh_survey(sample_frame,10)
```

## Future updates
