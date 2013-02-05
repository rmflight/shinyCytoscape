# test setup of graphs for Cytoscape

require(RCytoscape)
require(graph)
require(igraph)

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

cyTree <- CytoscapeWindow("tree", gTree)
displayGraph(cyTree)
layoutNetwork(cyTree)
redraw(cyTree)

cyLattice <- CytoscapeWindow("lattice", gLattice)
displayGraph(cyLattice)
layoutNetwork(cyLattice)
redraw(cyLattice)