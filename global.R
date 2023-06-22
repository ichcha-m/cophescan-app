library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(data.table)
library(DT)
library(plotly)
library(fontawesome)
library(gtools)
library(shinythemes)
library(shinyjs)
ukman = fread('data/bin_UKBB_manifest_both_sexes_mapped_phenotypes_201807.tsv')

return_plot <- function(cophe_out, col='aquamarine3'){
  df_pH <- data.frame(p=cophe_out$log10pval, Hc=cophe_out$Hc, Querytrait=cophe_out$L1, beta=as.factor(as.character(cophe_out$beta_sign)), short=cophe_out$querytrait)
  df_pH$Querytrait[is.na(df_pH$Querytrait)] = df_pH$short[is.na(df_pH$Querytrait)]
  g <-  ggplot(aes(x=p, y=Hc, label=Querytrait, shape=beta), data=df_pH) +
    geom_point(alpha=0.8, aes(shape=beta, fill=beta), size=4) +
    scale_shape_manual('beta', values = c('n'=25, 'p'=24)) +
    scale_fill_manual('beta', values = c('n'='aquamarine3', 'p'='firebrick')) +
    xlab("-log10(pval)") + ylab(label="Hc") +
    theme(axis.title=element_text(size=11, face = 'bold'), legend.title = element_text(size=11), panel.background = element_rect(fill = 'white'), legend.text = element_text(size=11),axis.text.y = element_text(size=11), axis.line = element_line(color='grey22')) + ylim(0,1)
  #ggsave(plot_name, width = 10, height = 7, dpi = 300, units = 'in')
  return(g)
}

get_prim <- function(prim_list){
  ret_list <- paste(ukman$`Phenotype Description`[match(prim_list, ukman$phenotype)], collapse=',')
  return(ret_list)
}

