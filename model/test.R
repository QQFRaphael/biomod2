library(biomod2)

species <- 'hongdoushan'
case <- 'current'

bm_out_file <- load("hongdoushan/hongdoushan.demo1.models.out")
en_bm_out_file <- load("hongdoushan/hongdoushan.demo1ensemble.models.out")

models <- get(bm_out_file)
ensemble_models <- get(en_bm_out_file)

## check variable importance
models_var_import <- get_variables_importance(ensemble_models)

## make the mean of variable importance by algorithm
#var_importance <- apply(models_var_import, c(1,2), mean)
print(models_var_import)
print("=======================")
#print(models)
#print(var_importance)
