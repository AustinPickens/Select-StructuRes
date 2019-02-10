#~~~~ Load ChemmineR ~~~~#
  library(ChemmineR )

#~~~~ Import list of metabolites ~~~~#  
  # Read a csv of metabolites in here
    metabolites <- read.csv('./metabolite_inputs.csv', header = T, stringsAsFactors = F)

#~~~~ Import and combine SDF files ~~~~#    
  # Enter the location of your SDF files here
    import.files <- list.files('./sdf') # default is within the package
    
    for(i in 1:length(import.files)){
    # The first entry will be used to make a data object to store everything
      if(i==1){
        # Read in the first file
          met.sdfs <- read.SDFset(paste('./sdf', import.files[i], sep = '/'))
        # Since the name doesn't come in, we will match the pubchem id to our list
          # you can view tmp@SDF and the default compound name for everything is CMP1
          id = met.sdfs@SDF[[1]][[1]][1]
        # Now that we identified the pubchem id of the imported sdf file, we can match it again our list
          met.sdfs@ID <- metabolites$Name[which(metabolites$Pubchem_ID==id)]
      } else {
        # Read in the next file
          tmp <- read.SDFset(paste('./sdf', import.files[i], sep = '/'))
        # Next we will add our newly imported SDF into our combined met.sdfs object
          met.sdfs[[i]] <- tmp[[1]]
        # Now that we have combined our SDFs in a single object, we need to rename the newly imported SDF
          id = tmp@SDF[[1]][[1]][1]
        met.sdfs@ID[i] <- metabolites$Name[which(metabolites$Pubchem_ID==id)]
      }
    }
    rm(i, tmp, id, import.files)
    save.image('input.data.rda') # save an RDA file with metabolite S4 object and csv information
