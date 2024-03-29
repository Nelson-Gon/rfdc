% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MethodDefinitions.R
\docType{methods}
\name{get_nutrients}
\alias{get_nutrients}
\alias{get_nutrients,FoodDetails-method}
\title{Get Nutrients given a FoodDetails Object}
\usage{
get_nutrients(object, target_field, ...)

\S4method{get_nutrients}{FoodDetails}(object, target_field, ...)
}
\arguments{
\item{object}{An object of class FoodSearch}

\item{target_field}{Target field to extract.}

\item{...}{Ignored}
}
\value{
Nutrients' data.frame.
}
\description{
Get Nutrients given a FoodDetails Object
}
\examples{
\dontrun{
test_object <-make_object("FoodDetails",fdc_id = 504905)
head(get_nutrients(test_object))
}
}
