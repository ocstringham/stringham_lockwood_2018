
#### function to run BRT, based off of dismo::gbm.step ####
### allows input of column names instead of column numbers

run_brt = function(data, # dataframe 
                   resp_col, # response variable column number
                   expl_cols, # vector of explanatory varirable names
                   tc = 3,lr = 0.0025, bf = 0.5, # machine learning paratemeters
                   verbose = F, ...){

  # convert response variables names to numbers
  x_cols = (colnames(data) %in% expl_cols) %>% which()

  
  # run BRT
  brt <- gbm.step(data, gbm.x = x_cols, 
                                 gbm.y = resp_col,
                                 family = "bernoulli", tree.complexity = tc,
                                 learning.rate = lr, bag.fraction = bf,
                                 # plot.main = F, 
                                 plot.folds = F, 
                                 verbose = verbose, ...)
  
  # return gbm object of BRT
  return(brt)
  
}





