# Method Definitions for Class FoodSearch
setGeneric("get_food_info", function(object,...) standardGeneric("get_food_info"))
setMethod("get_food_info", signature("FoodSearch"),
          function(object,target="description",
                   page_number=1,
                   require_all=TRUE,
                   sort_field="publishedDate",
                   sort_direction="asc"){
            
          
            
        search_query_list =   list(generalSearchInput = object@search_phrase,
                 ingredients = object@ingredients,
                 requireAllWords=require_all,
                 pageNumber=page_number,
                 sortField=sort_field,
                 sortDirection = sort_direction,
                 brandOwner = object@brand_owner)
    
 
        #return(httr::add_headers(`api_key` = object@api_key))
        
        res_response<-httr::POST(paste0("https://api.nal.usda.gov/fdc/v1/search?api_key=",
                          get_api_key()),
                   body = search_query_list, encode = "json",
                   httr::add_headers("Content-Type"="application/json"))
        
        # Make res more manipulatable
      res<-jsonlite::fromJSON(httr::content(res_response,"text"))
      
      if(length(target) ==1){
        
        res$foods[[target]]
      }
      
      else{
        
    do.call(data.frame,
                Map(function(x) res$foods[[x]],target))
        
        
      }
        
      
      
})

  
       