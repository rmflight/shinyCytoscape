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
  
  cyConnection <- CytoscapeConnection()
  
  switchGraphs <- function(inGraph, inName="graph"){
    deleteAllWindows(cyConnection)
    cyWindow <- new.CytoscapeWindow(inName, inGraph)
    displayGraph(cyWindow)
    layoutNetwork(cyWindow)
    redraw(cyWindow)
  }
  
  datasetInput <- reactive(function() {
    switch(input$dataset,
           "tree" = switchGraphs(gTree),
           "lattice" = switchGraphs(gLattice))
    
  })
  
  
})