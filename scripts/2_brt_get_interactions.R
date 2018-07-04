
#### script to calculate and plot interacting variables of BRT ####


library(gbm)
library(dismo)


#### load gbm object (output of BRT) ----
gbm_obj = readRDS("data/gbm_obj.rds")


#### load functions ----
source("scripts/functions/plot_brt_interactions_fun.R")



#### get interactions ----

# run GBM function to calculate interactions
gbm_int = gbm.interactions(gbm_obj)

# view interactions
gbm_int$interactions
gbm_int$rank.list




#### plot interactions (figure 4) ----
p1 = plot_brt_interactions_fun(gbm_obj, gbm_int, 
                               var_nos = c(5,1), 
                               contour_label_vec =  3, 
                               xlim = c(0,5), ylim = c(0,7.5), 
                               # axis_label_vec = c("reproduction (eggs/per)", "longevity (years)"),
                               # axis_label_vec = c("price($)", "time on market (years)"),
                               axis_label_vec = c("log 10 adult mass (g)", "log 10 quantity imported"),
                               color_heatmap = "blue", 
                               colorkey = F,
                               flip_ax = F)

p2 = plot_brt_interactions_fun(gbm_obj, gbm_int,
                               var_nos = c(5,2),
                               contour_label_vec =  3,
                               ylim = c(0.75,3.4), xlim = c(0,5),
                               axis_label_vec = c("log 10 adult mass (g)", "log 10 price (US$)"),
                               color_heatmap = "blue",
                               colorkey = F,
                               flip_ax = F)

p3 = plot_brt_interactions_fun(gbm_obj, gbm_int,
                               var_nos = c(4,1),
                               contour_label_vec =  2,
                               ylim = c(0,7.5), xlim = c(0,70),
                               axis_label_vec = c("longevity (years)", "log 10 quantity imported"),
                               color_heatmap = "blue",
                               colorkey = T,
                               flip_ax = F)
