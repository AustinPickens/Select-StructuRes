#~~~~ Install Packages ~~~~#
  list.of.packages <- c('DT', 'shiny','shinydashboard')
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)){
    install.packages(new.packages[new.packages!='ChemmineR'])
    if('ChemmineR' %in% new.packages) {
      source("https://bioconductor.org/biocLite.R")
      biocLite("ChemmineR")
    }
}