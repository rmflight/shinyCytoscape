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
    
    selectInput("dataset", "Choose a graph:", 
                choices = c("none","tree", "lattice")),
    
    submitButton("Apply")
  ),

  mainPanel(
    h3(textOutput("graphType"))
    
    )
  
))