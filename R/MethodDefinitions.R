#' Method definitions for the FoodSearch Class
#' @param object An object of class FoodSearch
#' @param target Target field to extract, can be a vector. Defaults to "description"
#' @param page_number Page number of results to return. Defaults to 1
#' @param sort_field Character specifying what field to use for sorting. Defaults to publicationDate
#' @param sort_direction One of 'asc' or 'desc' to sort results in ascending or descending order respectively.
#' @examples 
#' \dontrun{
#' my_object <- make_object("FoodSearch",search_phrase="indomie")
#' get_food_info(my_object,"description")
#' }
#' @export
setGeneric("get_food_info", function(object,...) standardGeneric("get_food_info"))
setMethod("get_food_info", signature("FoodSearch"),
          function(object,target="description",
                   page_number=1,
                   sort_field="publishedDate",
                   sort_direction="asc",
                   brand_owner = NULL){
            
          
            
        search_query_list =   list(query = object@search_phrase,
                 pageNumber=page_number,
                 sortBy=sort_field,
                 sortOrder = sort_direction,
                 brandOwner = brand_owner)
    
 
       
        
res_response<-httr::GET(paste0("https://api.nal.usda.gov/fdc/v1/search/?api_key=",
                          get_api_key()),
                   query = search_query_list)
      
      res<-jsonlite::fromJSON(httr::content(res_response,"text"))
      
      if(length(target) ==1){
        
        res$foods[[target]]
      }
      
      else{
        
    do.call(data.frame,
                Map(function(x) res$foods[[x]],target))
        
        
      }
        
      
      
})
#' Method definitions for the FoodDetails Class
#' @param object An object of class FoodSearch
#' @param target-field Target field to extract, can be a vector. Defaults to "description"
#' @examples 
#' \dontrun{
#' test_object <-make_object("FoodDetails",fdc_id = 504905)
#' get_food_details(test_object, "ingredients")
#' }
#' @export
setGeneric("get_food_details", function(object,...) standardGeneric("get_food_details"))

setMethod("get_food_details", signature = signature("FoodDetails"),
          function(object, target_field = NULL){
  res_response <- httr::GET(paste0("https://api.nal.usda.gov/fdc/v1/",
                           object@fdc_id,"?api_key=", get_api_key()))                               
  
    res_from_json <- jsonlite::fromJSON(httr::content(res_response,"text"))
    res_from_json[target_field]
})
#' Get Nutrients given a FoodDetails Object
#' @inheritParams get_food_info
#' @return A `data.frame` object showing nutrients of a given food based on FDC ID. 
#' @examples 
#' \dontrun{
#' test_object <-make_object("FoodDetails",fdc_id = 504905)
#' head(get_nutrients(test_object))
#' }
#' @export
setGeneric("get_nutrients", function(object,...) standardGeneric("get_nutrients"))

setMethod("get_nutrients", signature = signature("FoodDetails"),
          function(object,...){
            
    get_food_details(object,target_field="foodNutrients")$foodNutrients$nutrient
          })