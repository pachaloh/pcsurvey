
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pcsurvey

<!-- badges: start -->

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
#> Stratum:  1 
#> Nsize:  10 
#> Interval:  2563.8 
#> Random start:  1237.226 
#> Number of clusters:  30 
#> Stratum:  2 
#> Nsize:  10 
#> Interval:  4288.2 
#> Random start:  1173.886 
#> Number of clusters:  50
sample <- pc_pps_survey(sample_frame,nsize = c(10,7))
#> Stratum:  1 
#> Nsize:  10 
#> Interval:  2563.8 
#> Random start:  1062.766 
#> Number of clusters:  30 
#> Stratum:  2 
#> Nsize:  7 
#> Interval:  6126 
#> Random start:  2672.159 
#> Number of clusters:  50
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
