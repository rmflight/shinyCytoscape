require(shiny)
require(RCytoscape)
require(graph)
require(igraph)

initWindow <- function(inGraph, graphName, isBlank=FALSE){
  if (isBlank) {
    cyWindow <- new.CytoscapeWindow(title=graphName, graph=new('graphNEL'), overwriteWindow=TRUE)
  } else {
    cyWindow <- new.CytoscapeWindow(title=graphName, graph=inGraph, overwriteWindow=TRUE)
    displayGraph(cyWindow)
    layoutNetwork(cyWindow)    
  }
  return(cyWindow)
}

switchWindows <- function(inName){
  #browser(expr=TRUE)
  cyWindow <- new.CytoscapeWindow(inName, inGraph)
  displayGraph(cyWindow)
  layoutNetwork(cyWindow)
  redraw(cyWindow)
  return(inName)
}

gTree <- graph.tree(20, mode="out")
gLattice <- graph.lattice(length=5, dim=3)

gTree <- igraph.to.graphNEL(gTree)
gTree <- initEdgeAttribute(gTree, "weight", "numeric", 1)

gLattice <- igraph.to.graphNEL(gLattice)
gLattice <- initEdgeAttribute(gLattice, "weight", "numeric", 1)

cyConnection <- CytoscapeConnection()
hidePanel(cyConnection, "Control")

cyBlank <- initWindow(NULL, "blank", TRUE)
cyTree <- initWindow(gTree, "tree")
cyLattice <- initWindow(gLattice, "lattice")
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
    if (input$dataset == "none"){
      raiseWindow(cyBlank)
      graphName <- "none"
    }
    else if (input$dataset == "tree"){
      raiseWindow(cyTree)
      graphName <- "tree"
    } else if (input$dataset == "lattice"){
      raiseWindow(cyLattice)
      graphName <- "lattice"
    }
    return(graphName)
  })
  
  
})