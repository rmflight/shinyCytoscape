require(shiny)
require(RCytoscape)
require(graph)
require(igraph)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  gTree <- graph.tree(20, mode="out")
  gLattice <- graph.lattice(length=5, dim=3)
  
  gTree <- igraph.to.graphNEL(gTree)
  gTree <- initEdgeAttribute(gTree, "weight", "numeric", 1)
    
  gLattice <- igraph.to.graphNEL(gLattice)
  gLattice <- initEdgeAttribute(gLattice, "weight", "numeric", 1)
  
  datasetInput <- reactive(function() {
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # The output$summary depends on the datasetInput reactive function, 
  # so will be re-executed whenever datasetInput is re-executed 
  # (i.e. whenever the input$dataset changes)
  output$summary <- reactivePrint(function() {
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # The output$view depends on both the databaseInput reactive function
  # and input$obs, so will be re-executed whenever input$dataset or 
  # input$obs is changed. 
  output$view <- reactivePlot(function() {
    dataset <- datasetInput()
    p <- ggplot(dataset, aes_string(x=names(dataset)[1], y=names(dataset)[2])) + geom_point()
    print(p)
  })
})