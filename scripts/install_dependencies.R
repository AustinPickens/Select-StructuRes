#~~~~ Install Packages ~~~~#
  list.of.packages <- c('DT', 'shiny','shinydashboard')
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)){
    install.packages(new.packages[new.packages!='ChemmineR'])
    if('ChemmineR' %in% new.packages) {
      if(version[7] < 5){ # This should work with R pre-version 5
        source("https://bioconductor.org/biocLite.R")
        biocLite("ChemmineR")
       } else { # This should work with R version 5 and above
        if (!requireNamespace("BiocManager", quietly = TRUE))
          install.packages("BiocManager")
          BiocManager::install("ChemmineR", version = "3.8")
       }      
    }
}

## If you have any issues it is probably realted to your version of R and the bioconductor installer/ChemmineR
