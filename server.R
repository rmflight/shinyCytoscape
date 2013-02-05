require(shiny)
require(RCytoscape)
require(graph)
require(igraph)

gTree <- graph.tree(20, mode="out")
gLattice <- graph.lattice(length=5, dim=3)

gTree <- igraph.to.graphNEL(gTree)
gTree <- initEdgeAttribute(gTree, "weight", "numeric", 1)

gLattice <- igraph.to.graphNEL(gLattice)
gLattice <- initEdgeAttribute(gLattice, "weight", "numeric", 1)

cyBlank <- new.CytoscapeWindow("blank")
cyTree <- new.CytoscapeWindow("tree", gTree)
displayGraph(cyTree)
layoutNetwork(cyWindow)
cyLattice <- new.CytoscapeWindow("lattice", gLattice)
raiseWindow(cyBlank)

switchGraphs <- function(inGraph, inName="graph"){
  #browser(expr=TRUE)
  cyWindow <- new.CytoscapeWindow(inName, inGraph)
  displayGraph(cyWindow)
  layoutNetwork(cyWindow)
  redraw(cyWindow)
  return(inName)
}

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  output$graphType <- reactive(function() {
    #browser(expr=TRUE)
    cyConnection <- CytoscapeConnection()
    deleteAllWindows(cyConnection)
    graphName <- "none"
    if (input$dataset == "tree"){
      graphName <- switchGraphs(gTree, "tree")
    } else if (input$dataset == "lattice"){
      graphName <- switchGraphs(gLattice, "lattice")
    }
    return(graphName)
  })
  
  
})