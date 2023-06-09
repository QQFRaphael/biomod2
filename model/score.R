library(biomod2)
library(ggplot2)

species <- 'hongdoushan'
case <- 'MIROC-ES2L-ssp585-2081-2100'

bm_out_file <- load("hongdoushan/hongdoushan.demo1.models.out")
en_bm_out_file <- load("hongdoushan/hongdoushan.demo1ensemble.models.out")

models <- get(bm_out_file)
ensemble_models <- get(en_bm_out_file)

## asses ensemble models quality ----
ensemble_models_scores <- get_evaluations(ensemble_models)

mygraph<-models_scores_graph(
  models, 
  by = "models" , 
  metrics = c("TSS","ROC"), 
  xlim = c(0.55,1.0), 
  ylim = c(0.75,1.0)
)

#mygraph + theme(panel.background=element_rect(fill = "#64D2AA", color = "#64D2AA", size = 2))
mygraph + theme_bw() + theme(legend.background = element_rect(fill = "white", size = 4, colour = "white"),axis.ticks = element_line(colour = "grey70", size = 0.8))+ scale_colour_brewer(type = "seq", palette = "Spectral")
