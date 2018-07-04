
#### script to run boosted regression trees model and view results ####


library(gbm)
library(dismo)
library(magrittr)

#### load data ---
df = readRDS("data/lht_economics_database.rds")


#### load functions ----
source("scripts/functions/brt_return_summary_stats_fun.R")
source("scripts/functions/brt_step_fun.R")
source("scripts/functions/brt_contrs_range_fun.R")


#### select columns for BRT

# view column names
colnames(df)

# convert some cols to log10 for easier visualization
df$sum_qty = log10(df$sum_qty)
df$adult_mass_g = log10(df$adult_mass_g)
df$median_price = log10(df$median_price)
df$fecundity = log10(df$fecundity)


# select response variable (release or no release)
resp_col = 19

# select explanatory variables
exp_cols = c( "median_price",  "sum_qty",  "max_life_yr",
              "adult_mass_g","fecundity" ,"resid_time")



#### run BRT ----
## note that BRT is stochastic so will result in slightly different outputs 


brt = run_brt(df, 
              resp_col =  resp_col, # response variable
              expl_cols = exp_cols, # explanatory variables
              tc = 3, lr = 0.001, bf = 0.5, # machine learning parameters
              n.folds = 10, # number of CV folds
              verbose = T, 
              plot.main = T)


## save gbm obj
saveRDS(brt, "data/gbm_obj.rds")

# load gbm obj
# brt = readRDS("data/gbm_obj.rds")



#### view results ----

# get summary stats of model fit
brt_return_summary_stats(brt)

# get variable details
brt_contrs_range_fun(brt)

## plot responses

# plot PDPs w/o response
gbm.plot(brt)

# plot PDPs w/ response
x11()
par(mfrow=c(3,3))
for(i in 1:length(exp_cols)){plot.gbm(brt, i.var = i, type = "response", ylim = c(0,1))}



