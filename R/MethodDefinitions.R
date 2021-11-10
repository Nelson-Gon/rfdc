#' Method definitions for the FoodSearch Class
#' @param object An object of class FoodSearch
#' @param target Target field to extract, can be a vector. Defaults to "description"
#' @param page_number Page number of results to return. Defaults to 1
#' @param sort_field Character specifying what field to use for sorting. 
#' Defaults to publicationDate
#' @param sort_direction One of 'asc' or 'desc' to sort results in ascending or 
#' descending order respectively.
#' @param brand_owner Brand owner.
#' @param ... Ignored. 
#' @docType methods
#' @rdname get_food_info
#' @examples 
#' \dontrun{
#' my_object <- make_object("FoodSearch",search_phrase="indomie")
#' get_food_info(my_object,"description")
#' }
#' @export 
setGeneric("get_food_info", function(object,target="description",
                                     page_number=1,
                                     sort_field="publishedDate",
                                     sort_direction="asc",
                                     brand_owner = NULL,
                                     ...) 
  standardGeneric("get_food_info"))
#' @aliases get_food_info 
#' @rdname get_food_info
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
    
 
       
        
res_response<-httr::GET(paste0("https://api.nal.usda.gov/fdc/v1/foods/search/?api_key=",
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
#' @param target_field Target field to extract, can be a vector. 
#' @param result_format One of abridged or full. Defaults to full.
#' @param nutrients A numeric vector of nutrient IDs. 
#' Defaults to "description"
#' @param ... Ignored. 
#' @docType methods
#' @rdname get_food_details 
#' @return A data.frame of the target field
#' @examples 
#' \dontrun{
#' test_object <-make_object("FoodDetails",fdc_id = 504905)
#' get_food_details(test_object, "ingredients")
#' }
#' @export
setGeneric("get_food_details", function(object,target_field = "ingredients",
                                        result_format="full",
                                        nutrients = NULL, 
                                        ...) 
  standardGeneric("get_food_details"))
#' @aliases get-food-details
#' @rdname get_food_details
# TODO: define format abridged etc
# TODO: Better docs and flexibility. 
setMethod("get_food_details", signature = signature("FoodDetails"),
          function(object, target_field = NULL,
                   result_format="full",
                   nutrients = NULL){
get_url <- paste0("https://api.nal.usda.gov/fdc/v1/food/",
                  object@fdc_id,"?api_key=", get_api_key(),
                  "&format=",result_format,"&nutrients=",
                  paste0(nutrients, collapse=","))

print(paste0("Using URL: ", gsub("(api_key=)(.*)(&.*)","\\1*****\\3",get_url), collapse=""))
                        
            
res_response <- httr::GET(get_url)                               
  
res_from_json <- jsonlite::fromJSON(httr::content(res_response,"text"))
if (target_field == "all") res_from_json else(res_from_json[target_field]) 
# res_from_json
})
#' Get Nutrients given a FoodDetails Object
#' @param object An object of class FoodSearch
#' @param target_field Target field to extract.
#' @param ... Ignored 
#' @docType methods 
#' @rdname get_nutrients 
#' @return Nutrients' data.frame. 
#' @examples 
#' \dontrun{
#' test_object <-make_object("FoodDetails",fdc_id = 504905)
#' head(get_nutrients(test_object))
#' }
#' @export
setGeneric("get_nutrients", function(object,target_field,...) standardGeneric("get_nutrients"))
#' @aliases get_nutrients
#' @rdname get_nutrients 
setMethod("get_nutrients", signature = signature("FoodDetails"),
          function(object,target_field,...){
    food_details <- get_food_details(object,target_field="foodNutrients")$foodNutrients            
    nutrients<- food_details$nutrient
    nutrients$serving <- food_details$amount
    nutrients$serving_descr <- food_details$foodNutrientDerivation$description
    nutrients 
          })

#' Get Label Nutrients given a FoodDetails Object
#' @param object An object of class FoodSearch
#' @param target_field Target field to extract.
#' @param ... Other params to get_food_details. 
#' @docType methods 
#' @rdname get_label_nutrients 
#' @return Nutrients' data.frame. 
#' @examples 
#' \dontrun{
#' test_object <-make_object("FoodDetails",fdc_id = 504905)
#' head(get_label_nutrients(test_object))
#' }
#' @export
setGeneric("get_label_nutrients", function(object,target_field,...) standardGeneric("get_label_nutrients"))
#' @aliases get_label_nutrients
#' @rdname get_label_nutrients 
setMethod("get_label_nutrients", signature = signature("FoodDetails"),
          function(object,target_field,...){
        food_details <- get_food_details(object,target_field="all",...)
        label_nutrients_obj <- 
        res<-data.frame(lapply(food_details$labelNutrients, "[[",1))
        if(is.null(unlist(res))){
          stop(paste0("FDC ID ", object@fdc_id, " has not label nutrients."))
        }
        res

})

