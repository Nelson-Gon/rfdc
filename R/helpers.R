#' Sets a user's session API key
#' @param api_key An api key as obtained from Food Data Central
#' @examples 
#' \dontrun{
#' set-api_key("my key here")
#' }
#' @return Sets the session api key
#' @export

set_api_key <- function(api_key = NULL){
  
  if(is.null(api_key)){
 key_signup()
  }
  else{
    Sys.setenv("api_key" = api_key)
    message("API key now set for this session.")
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
 if(Sys.getenv("api_key") == ""){
   stop("A session API key is required. Did you run set_api_key first?")
 }
  else{
    Sys.getenv("api_key")
  }
  
}
