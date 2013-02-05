# test setup of graphs for Cytoscape

require(RCytoscape)
require(graph)
require(igraph)
require(shiny)

gTree <- graph.tree(20, mode="out")
gLattice <- graph.lattice(length=5, dim=3)

gTree <- igraph.to.graphNEL(gTree)
gTree <- initEdgeAttribute(gTree, "weight", "numeric", 1)

gLattice <- igraph.to.graphNEL(gLattice)
gLattice <- initEdgeAttribute(gLattice, "weight", "numeric", 1)

switchGraphs <- function(inGraph, inName="graph"){
  #browser(expr=TRUE)
  cyConnection <- CytoscapeConnection()
  deleteAllWindows(cyConnection)
  cyWindow <- new.CytoscapeWindow(inName, inGraph)
  displayGraph(cyWindow)
  layoutNetwork(cyWindow)
  redraw(cyWindow)
}

input <- list(dataset="lattice")

if (input$dataset == "tree"){
  switchGraphs(gTree, "tree")
} else if (input$dataset == "lattice"){
  switchGraphs(gLattice, "lattice")
}