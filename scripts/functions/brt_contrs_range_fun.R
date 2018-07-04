
#### function to generate easy to read output for variable contributions of BRT ####

brt_contrs_range_fun = function(brt_obj){
  
  brt = brt_obj
  
  require(gbm)
  require(dismo)
  require(dplyr)
  require(plyr)

  # initial variables
  brt_list = list()
  min_max = list()
  
  
  # loop through each explanatory variable
  for(i in 1:nrow(brt$contributions)){
    
    
    # get response (p(release) at given values for a variable) for each variable
    brt_list[[i]] = plot.gbm(brt, i.var = i, type = "response", return.grid = TRUE)
    
    # get delta P(release) = max - min 
    min_max[[i]] = max(brt_list[[i]][2]) - min(brt_list[[i]][2])
    
  }
  
  
  # combine in df
  range_df = 
    cbind.data.frame(var = brt$var.names, 
                     range = unlist(min_max))
  

  
  # join % cotributions
  range_df = left_join(range_df, brt$contributions, by = c("var" = "var"))
  

  # sort by delta p(release)
  range_df = arrange(range_df, -range)
  
  
  return(range_df)
  
}

