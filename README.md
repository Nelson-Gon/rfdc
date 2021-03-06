Nelson Gonzabato
2020-06-15

# rfdc: An R Interface to FoodData Central

[![Build
Status](https://travis-ci.org/Nelson-Gon/rfdc.png?branch=master)](https://travis-ci.org/Nelson-Gon/rfdc)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-3.0.html)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Nelson-Gon/rfdc/graphs/commit-activity)
[![Project
Status](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![GitHub last
commit](https://img.shields.io/github/last-commit/Nelson-Gon/rfdc.svg)](https://github.com/Nelson-Gon/rfdc/commits/master)
[![GitHub
issues](https://img.shields.io/github/issues/Nelson-Gon/rfdc.svg)](https://GitHub.com/Nelson-Gon/rfdc/issues/)
[![GitHub
issues-closed](https://img.shields.io/github/issues-closed/Nelson-Gon/rfdc.svg)](https://GitHub.com/Nelson-Gon/rfdc/issues?q=is%3Aissue+is%3Aclosed)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# Background

This repository is intended to serve as a replacement to the R package
[usdar](https://github.com/Nelson-Gon/usdar). This was necessary because
the former API is slated for End of Life as explained in issue
[\#2](https://github.com/Nelson-Gon/usdar/issues/2).

It is also based on [pyfdc](https://github.com/Nelson-Gon/pyfdc)

**Installation**

To install the package, one requires to have `devtools` installed. The
package is not on CRAN and the author does not intend to push it to CRAN
unless specific need arises.

``` r

install.packages("devtools")
devtools::install_github("Nelson-Gon/rfdc")
```

**Loading the package**

``` r

library(rfdc)
#> Please run set_api_key first.Run key_signup to get an API key.
```

**Initial Setup**

As a first step, we need to set an API key for the session via
`set_api_key` as shown below.

``` r
set_api_key("key_here")
```

To signup for an API key:

``` r

key_signup()
```

**Initialise an object**

To intialise an object, we can use `make_object`. See details about each
class below. For instance, to initialise an object of class `FoodSearch`
with the search term `indomie`:

``` r

my_object <- make_object("FoodSearch",search_phrase="indomie")
```

**Classes**

1.  `FoodSearch` class

This class allows access to the food search
[endpoint](https://fdc.nal.usda.gov/api-guide.html) i.e to search/query
the database.

**Available methods**

1.  `get_food_info`

To get details about our object above:

``` r

get_food_info(my_object,"description")
#> [1] "CHICKEN INSTANT NOODLES, CHICKEN"
```

To get multiple details:

``` r

get_food_info(my_object,c("description",'fdcId','score'))
#>                        description  fdcId     score
#> 1 CHICKEN INSTANT NOODLES, CHICKEN 686856 -696.3518
```

Another example:

``` r

head(get_food_info(my_object,c('fdcId','description','score')))
#>    fdcId                      description     score
#> 1 686856 CHICKEN INSTANT NOODLES, CHICKEN -696.3518
```

2.  `get_food_details`

For the `FoodDetails` class, this returns details about a food data
central id. You can get an fdcId using `get_food_info` from `FoodSearch`

``` r

test_object <-make_object("FoodDetails",fdc_id = 504905)

get_food_details(test_object, "ingredients")
#> $ingredients
#> [1] "MECHANICALLY SEPARATED CHICKEN, CHICKEN BROTH, WATER, CONTAINS LESS THAN 2% OF: SALT, SUGAR, SPICES, SODIUM PHOSPHATE, SODIUM ASCORBATE, SODIUM NITRITE, NATURAL FLAVORS, EXTRACTIVES OF PAPRIKA."
```

3.  `get_nutrients`

To get nutrients corresponding to a food id:

``` r

head(get_nutrients(test_object))
#>     id number                                     name rank unitName
#> 1 1079    291                     Fiber, total dietary 1200        g
#> 2 1087    301                              Calcium, Ca 5300       mg
#> 3 1089    303                                 Iron, Fe 5400       mg
#> 4 1092    306                             Potassium, K 5700       mg
#> 5 1110    324 Vitamin D (D2 + D3), International Units 8650       IU
#> 6 1003    203                                  Protein  600        g
```

Further exploration is left to the user.

Please note that the ‘rfdc’ project is released with a [Contributor Code
of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
