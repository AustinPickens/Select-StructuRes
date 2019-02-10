library(shiny)
library(shinydashboard)
library(DT)
library(ChemmineR)

load('input.data.rda')

#~~~ Build UI for the application ~~~#
ui <- dashboardPage(
        dashboardHeader(title = "Select StructuRes"),
        dashboardSidebar(),
        dashboardBody(
          h1('S'),
      		DTOutput('MetDbase.Table'),
        	fluidRow(
        	  column(
        	    width = 4,
        	    plotOutput('Structure1')
        	  ),
        	  column(
        	    width = 4,
        	    plotOutput('Structure2')
        	  ),
        	  column(
        	    width = 4,
        	    plotOutput('Structure3')
        	  )
        	)
        )
      )

server <- function(input, output) {
  #~~~ Display Data ~~~#
     output$MetDbase.Table <- renderDT({
                                datatable(
                                  metabolites,
                                  caption = 'Click metabolites in the table',
                                  options = list( lengthChange = T),
                                  selection = list(mode = 'multiple') # this option allows multiple selections to be passed back to R
                                )
                              })

  #~~~ Display Plots ~~~#
     output$Structure1 <- renderPlot({
                           num_selections <- input$MetDbase.Table_rows_selected # pass multiple selections to another object
                           ## First Plot
                           if(is.null(input$MetDbase.Table_rows_selected)!=T){ # if user selections are not NULL
                               selection.1 <- which(met.sdfs@ID==metabolites$Name[num_selections[1]]) # check which S4 object id match metabolites in table
                                if(length(selection.1)){ # if a user selection exists
                                  plot(met.sdfs[selection.1], atomnum=F) # plot user selection 1
                                }
                                if(length(num_selections)==1){ # this clears plots 2 and 3 after deselecting table entry 2 and 3
                                  output$Structure2 <- renderPlot({})
                                  output$Structure3 <- renderPlot({})
                                }
                           ## Second Plot
                            if(length(num_selections)>1&is.null(input$MetDbase.Table_rows_selected)!=T){ # if user selected multiple entries
                             output$Structure2 <- renderPlot({
                               selection.2 <- which(met.sdfs@ID==metabolites$Name[num_selections[2]])
                               if(length(selection.2)){
                                 plot(met.sdfs[selection.2], atomnum=F)
                               }
                               if(length(num_selections)==2){ # this clears plot 3 after deselecting a 3rd table entry
                                 output$Structure3 <- renderPlot({})
                               }
                             })
                            }
                           ## Third Plot
                            if(length(num_selections)>2&is.null(input$MetDbase.Table_rows_selected)!=T){
                             output$Structure3 <- renderPlot({
                               selection.3 <- which(met.sdfs@ID==metabolites$Name[num_selections[3]])
                               if(length(selection.3)){
                                 plot(met.sdfs[selection.3])
                               }
                             })
                            }
                           } else{
                             output$Structure2 <- renderPlot({})
                             output$Structure3 <- renderPlot({})
                           }
                         })

}

shinyApp(ui, server)
