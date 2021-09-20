#' FoodSearch Class
#' @export
#' @slot search_phrase A phrase to use when querying the database

setClass("FoodSearch",
         representation = representation(search_phrase="character"))

#' FoodDetails 
#' @export
#' @slot fdc_id A food id whose details are required. 
setClass("FoodDetails",
         representation = representation(fdc_id = c("numeric")))

# This is too manual
# I will revisit this sometime later
# For now only use character as the repr
#setOldClass("FoodDetailsSingle")

