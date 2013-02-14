require(shiny)
require(RCytoscape)
require(graph)
require(igraph)

#' generates a random graph using the barabasi algorithm of growing a graph, and assigns one node a color
#' 
#' @param nNodes the number of nodes to have in the graph
genRandomGraphs <- function(nNodes){
  tmpGraph <- barabasi.game(nNodes)
  
  tmpGraph <- igraph.to.graphNEL(tmpGraph)
  tmpGraph <- initEdgeAttribute(tmpGraph, "weight", "numeric", 1)
  
  tmpGraph <- initNodeAttribute(tmpGraph, "isSpecial", "char", FALSE)
  
  # choose one node at random to be special
  specialNode <- sample(nNodes, 1)
  nodeData(tmpGraph, as.character(specialNode), "isSpecial") <- TRUE
  
  return(list(graph=tmpGraph, isSpecial=specialNode))
}

nNodes <- floor(rnorm(5, 40, 5))

inputGraphs <- lapply(nNodes, genRandomGraphs)

switchWindow <- function(inGraph, graphName, isBlank=FALSE){
  if (isBlank) {
    cyWindow <- new.CytoscapeWindow(title=graphName, graph=new('graphNEL'), overwriteWindow=TRUE)
  } else {
    cyWindow <- new.CytoscapeWindow(title=graphName, graph=inGraph, overwriteWindow=TRUE)
    displayGraph(cyWindow)
    layoutNetwork(cyWindow)    
  }
  return(cyWindow)
}

gTree <- graph.tree(20, mode="out")
gLattice <- graph.lattice(length=5, dim=3)

gTree <- igraph.to.graphNEL(gTree)
gTree <- initEdgeAttribute(gTree, "weight", "numeric", 1)

gLattice <- igraph.to.graphNEL(gLattice)
gLattice <- initEdgeAttribute(gLattice, "weight", "numeric", 1)

cyConnection <- CytoscapeConnection()
hidePanel(cyConnection, "Control")

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  output$graphType <- reactive(function() {
    #browser(expr=TRUE)
    if (input$dataset == "none"){
      switchWindow(NULL, "none", TRUE)
      graphName <- "none"
    }
    else if (input$dataset == "tree"){
      switchWindow(gTree, "tree")
      graphName <- "tree"
    } else if (input$dataset == "lattice"){
      switchWindow(gLattice, "lattice")
      graphName <- "lattice"
    }
    return(graphName)
  })
  
  
})