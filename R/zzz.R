# Remind me to start a startup

.onAttach <- function(...){
  
  startup_msg <- "Please run set_api_key first.Run key_signup to get an API key."
  packageStartupMessage(startup_msg)
}