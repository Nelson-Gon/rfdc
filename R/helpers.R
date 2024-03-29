#' Sets a user's session API key
#' @param api_key An api key as obtained from Food Data Central
#' @examples 
#' \dontrun{
#' set-api_key("my key here")
#' }
#' @return Sets the session api key
#' @export

set_api_key <- function(api_key = NULL){
  
  if(all(is.null(api_key), Sys.getenv("rfdc_key") == "")){

      key_signup()
      
    }

  else{
    if(Sys.getenv("rfdc_key") != ""){
      message("AN API key already exists, enjoy!")
    }
    else{
      Sys.setenv("rfdc_key" = api_key)
      message("API key now set for this session.")
      
    }

  }
}


#' Directs user to the api key signup page
#' @return Opens a browser tab to the FDC api key sign up page
#' @export

key_signup <- function(){
  
  
user_answer<- readline("No api key supplied. Do you want to sign up for a key?")
  
if(grepl("[yY]es|[yY]",user_answer)){
    message("Great! Now taking you to the api key signup page")
    utils::browseURL("https://fdc.nal.usda.gov/api-key-signup.html")
  }
  else{
    stop("An api key is required")
  }
}


#' Retrieves a user's session API key
#' @export

get_api_key <- function(){
 if(Sys.getenv("rfdc_key") == ""){
   stop("A session API key is required. Did you run set_api_key first?")
 }
  else{
    Sys.getenv("rfdc_key")
  }
  
}

#' Makes an object of either FoodDetails or FoodSearch
#' @importFrom methods new
#' @param object_class Class of the object eg FoodSearch
#' @param ... Other arguments to the object's class definitions. 
#' @export

make_object <- function(object_class=NULL,...){
  new(object_class,...)
}