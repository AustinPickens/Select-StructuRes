# Select-StructuRes
An interactive method of displaying small molecule structures from a table

Select-StructuRes is an R Shiny-based application that combines functionality of the DT package with the ChemmineR package, allowing molecular structures of small molecules to be displayed when a user selects table entries. This guide assumes users have very little experience in R or programming, but already have R and R Studio installed.

To use this application:

1) create an R project and clone this github repository into it.

2) In the scripts folder, open the file called install_dependencies.R. This will install the necessary R packages so the application can launch.

3) Open the app.R file and run it for a local application instance 

Modifying the small molecules and displayed table fields is easy. Users can enter the list of small molecules they wish to display by opening the metabolite_input.csv file. Additional columns can be added to this file to display more information, such as molecular formula, SMILES, HMDB IDs, etc. Users can add additional metabolites by inserting or appending new rows to the file. It is important to note that for the application to function, the columns Name and Pubchem_ID must remain and are case sensitive.

To add new small molecules and structures:

1) First go to https://pubchem.ncbi.nlm.nih.gov/. Find the ID for the small molecule by searching its name. Enter the name and corresponding Pubchem ID to the file metabolite_input.csv and save the file. If you launch the application, your new entries should appear in the table, but you will not see their structures yet. 

2) To add the structures, you now need to visit https://pubchem.ncbi.nlm.nih.gov/pc_fetch/pc_fetch.cgi and download the SDF file for your Pubchem ID. There are automated ways to do this, but we will not cover that here. The SDF files will be gzipped and named some string of alphanumeric text, that is okay because the file contains the Pubchem ID so we can identify it.

3) Next after unzipping the SDF files, move them to your project into the sdf folder. The script you will run next checks that folder for new entries.

4) Lastly, in the scripts folder run the file import_and_merge_sdfs.R. This script checks the SDF file Pubchem ID against the small molecule list you entered into the file metabolite_input.csv. If an ID or file isn't found, it will move on and this structure will not display. In order for this script to work, you must have previously run the install_dependencies.R file. 

If you want to make this more sophisticated, you can change the source code to link to a SQL or SQLite database.

Troubleshooting:
The most likley issue you may have is getting ChemmineR installed, due to requirments for bioconductor on different versions of R. To fix this issue, please visit https://www.bioconductor.org/packages/release/bioc/html/ChemmineR.html. I haven't encountered any issues yet, but let me know if you have any.
