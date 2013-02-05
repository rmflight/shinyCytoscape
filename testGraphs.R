# test setup of graphs for Cytoscape

require(RCytoscape)
require(graph)
require(igraph)

gTree <- graph.tree(20, mode="out")
gLattice <- graph.lattice(length=5, dim=3)

gTree <- igraph.to.graphNEL(gTree)
gLattice <- igraph.to.graphNEL(gLattice)