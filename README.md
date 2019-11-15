# rfdc: An R Interface to FoodData Central

[![Build Status](https://travis-ci.org/Nelson-Gon/rfdc.png?branch=master)](https://travis-ci.org/Nelson-Gon/rfdc) [![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-3.0.html) [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

# Background
This repository is intended to serve as a replacement to the R package [usdar](https://github.com/Nelson-Gon/usdar). This was necessary because the former API is slated for End of Life as explained in issue [#2](https://github.com/Nelson-Gon/usdar/issues/2). 

---

# Installation

To install the package, one requires to have `devtools` installed. The package is not on CRAN and the author(s) do(es) not intend to push it  to CRAN  unless specific need arises.

```
# install.packages("devtools")
devtools::install_github("Nelson-Gon/rfdc")

```

## Initial Setup

As a first step, we need to set an API key for the session via `set_api_key` as shown below.

```
set_api_key("key_here")

```
You can sign up for an API key [here](https://fdc.nal.usda.gov/api-key-signup.html)

