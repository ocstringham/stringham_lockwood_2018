
#### function to return r2 and AUC for CV and full model ####

brt_return_summary_stats = function(gbm_object){
  
  # grab r2 and AUC for CV and full model
  v1 = gbm_object$self.statistics$correlation
  v2 = gbm_object$cv.statistics$correlation.mean
  v3 = gbm_object$self.statistics$discrimination
  v4 = gbm_object$cv.statistics$discrimination.mean
  
  
  # combine in one df
  df_brt_stats = cbind.data.frame(
                                  corr_train = v1,
                                  corr_cv = v2,
                                  auc_train = v3,
                                  auc_cv = v4)
  
  return(df_brt_stats)
  
}


#### notes ----
# $self.statistics$correlation = training data correlation
# $cv.statistics$correlation.mean = cv correlation

# $self.statistics$discrimination = training data AUC score
# $cv.statistics$dicrimination.mean = cv AUC score