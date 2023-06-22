pkgs <- c('shiny','shinydashboard','ggplot2','dplyr','data.table','DT','dashboardthemes','plotly','fontawesome','gtools','shinythemes','shinyjs','viridis','rmarkdown')
toInstall <- pkgs[!(pkgs %in% installed.packages()[ , "Package"])]
if(length(toInstall)) install.packages(toInstall)
