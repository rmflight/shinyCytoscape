require(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Shiny Cytoscape"),
  
  # Sidebar with controls to provide a caption, select a dataset, and 
  # specify the number of observations to view. Note that changes made
  # to the caption in the textInput control are updated in the output
  # area immediately as you type
  sidebarPanel(
    
    textInput("isSpecial", "Which node is different than the others:", 
                "none")),
    
    submitButton("Next Graph")
  ),

  mainPanel(
    h4(textOutput("whichGraph"))
    
    )
  
))