#!/usr/bin/env Rscript
run <- function(infile, outfile){
  load('data.RData')
  
  tmp <- read.csv('features.csv')
  tmp$X <- NULL
  fs <- as.vector(t(tmp)[, 1])
  # infile <- 'server/test_X.csv'
  X <- read.csv(infile)
  colnames(X) <- fs
  for (f in fs){
    X[[f]] <- as.numeric(X[[f]])
  }

  pred_df <- pred_models(model_list, X[, fs], 0.6)
  
  write.csv(pred_df, outfile, row.names = F)
}

pred_models <- function(model_list, X, cutoff){
  calibrate_model_list <- model_list$calibrate_model_list
  model_list <- model_list$model_list
  df <- data.frame(row.names = rownames(X))
  for (m in names(model_list)){
    df[[m]] <- pred_func(model_list[[m]], calibrate_model_list[[m]], X)
  }
  rownames(df) <- rownames(X)
  df$Ensemble <- df$LR*0.25 + df$SVM*0.3 + + df$GBDT*0.1 + df$NN*0.35
  df$Cluster <- as.factor(as.numeric(df$Ensemble >= cutoff))
  df$`Risk group`[df$Cluster == '0'] <- 'Non critical'
  df$`Risk group`[df$Cluster == '1'] <- 'Critical'
  return(df)
}


pred_func <- function(model, calibrate_model, X){
  pred_y <- predict(model, newdata = X, type='prob')[[2]]
  tmp <- data.frame(X=pred_y)
  calibrated_y <- predict(calibrate_model, newdata = tmp, type = "prob")[[2]]
  return (calibrated_y)
}

library("optparse")
# run MRPMC (Mortality Risk Prediction Model for COVID-19)
option_list = list(
  make_option(c("-i", "--infile"), type="character", default=NULL, 
              help="Path of X input file", metavar="character"),
  make_option(c("-o", "--outfile"), type="character", default=NULL, 
              help="Path of Y output file", metavar="character")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


if (is.null(opt$infile) || is.null(opt$outfile)){
  print_help(opt_parser)
  stop("input and output file path must be supplied.", call.=FALSE)
}

run(opt$infile, opt$outfile)
