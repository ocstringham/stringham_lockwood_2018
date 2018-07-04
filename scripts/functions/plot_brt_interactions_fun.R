
#### function to plot BRT interactions ####


plot_brt_interactions_fun = function(
  gbm.obj, # gbm object
  gbm.int, # gbm interactions object
  var_nos, # which int to plot
  contour_label_vec, # which label vec to use
  axis_label_vec, # change axis labels
  color_heatmap, # color of contour
  flip_ax = FALSE, # flip x and y axis
  ...
)
{
  
  # colors
  require(RColorBrewer)
  if(color_heatmap == "blue"){
    color1 = colorRampPalette(brewer.pal(9,'YlGnBu'))(10)
  }else if(color_heatmap == "grey"){
    color1 = colorRampPalette(brewer.pal(9,'Greys'))(10)
  }
  
  
  
  
  # generate different contour labels
  lable_list = list()
  lable_list[[1]] = seq(0,1,length.out = 11)
  lable_list[[2]] = c(0,0.1,0.2,0.3,0.4,"",0.6,"",0.8,"",1.0)
  lable_list[[3]] = c(0,0.1,0.2,"",0.4,"",0.6,0.7,0.8,0.9,1.0)
  lable_list[[4]] = c(0,0.1,0.2,0.3,"",0.5,0.6,0.7,0.8,0.9,1.0)
  

  # change axis names to match function input
  gbm.obj$var.names[var_nos[1]] = axis_label_vec[1]
  gbm.obj$var.names[var_nos[2]] = axis_label_vec[2]
  
  # grab which vars are being plotted
  var1 = gbm.obj$var.names[var_nos[1]]
  var2 = gbm.obj$var.names[var_nos[2]]
  
  # flip axis if asked
  if(flip_ax){ vars = c(var2, var1)}else{ vars = c(var1, var2)}
  

  # plot  
  plot.gbm(gbm.obj, i.var = vars, 
           type = "response",
           at = seq(0,1, length.out = 11), col.regions = color1,
           contour = T, labels = lable_list[[contour_label_vec]],
           pretty = T, 
           #label.style = "flat", 
           ...)
  
}
