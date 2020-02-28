#' FoodSearch Class
#' @export
#' @slot api_key An api key as obtained from FoodDataCentral
#' @slot search_phrase A phrase to use when querying the database
#' @slot brand_owner A character specifying who owns the brand e.g usa
#' @slot ingredients An optional ingredients phrase

setClass("FoodSearch",
         representation = representation(api_key="character",
                                         search_phrase="character",
                                         brand_owner="character",
                                         ingredients = "character"),
         prototype = prototype(api_key = Sys.getenv("api_key")),
         validity = function(object){
           no_key_errors <- NULL
           if(Sys.getenv("api_key") == ""){
         no_key_errors <- c(no_key_errors,
                "No api key found. Did you run set_api_key first?")
           }
           if(is.null(no_key_errors)) TRUE else no_key_errors
         })

#' FoodDetails class
#' @export
#' @slot fdc_id A food id whose details are required. 
setClass("FoodDetails",
         representation = representation(fdc_id = "character"),
         validity = function(object){
           no_key_errors <- NULL
           if(Sys.getenv("api_key") == ""){
             no_key_errors <- c(no_key_errors,
                "No api key found. Did you run set_api_key first?")
           }
           if(is.null(no_key_errors)) TRUE else no_key_errors
         })
