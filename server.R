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
  
  return(list(graph=tmpGraph, isSpecial=specialNode, isBlank=FALSE))
}

nNodes <- floor(rnorm(5, 40, 5))

inputGraphs <- lapply(nNodes, genRandomGraphs)
blankItem <- vector("list", 1)
blankItem[[1]]$graph <- "t"
blankItem[[1]]$isSpecial <- "none"
blankItem[[1]]$isBlank <- TRUE
inputGraphs <- c(blankItem, inputGraphs)

switchWindow <- function(inGraph, graphName, isBlank=FALSE){
  deleteAllWindows(cyConnection)
  if (isBlank) {
    cyWindow <- new.CytoscapeWindow(title=graphName, graph=new('graphNEL'), overwriteWindow=TRUE)
  } else {
    cyWindow <- new.CytoscapeWindow(title=graphName, graph=inGraph, overwriteWindow=TRUE)
    displayGraph(cyWindow)
    layoutNetwork(cyWindow)    
  }
  return(cyWindow)
}

writeResults <- function(outFile, outResults, inGraph){
  cat(outResults, inGraph$isSpecial, "\n", sep="\t", file=outFile, append=T)
}

cyConnection <- CytoscapeConnection()
hidePanel(cyConnection, "Control")
switchWindow(NULL, "start", TRUE)

outPutFile <- "testOutput.txt"
cat("userChoice", "truth", "\n", sep="\t", file=outPutFile, append=F)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  counter <- 1
  maxCount <- length(inputGraphs)
  
  basicStr <- "You are on graph"
  
  output$whichGraph <- reactive(function() {
    writeResults(outPutFile, input$isSpecial, inputGraphs[[counter]])
    
    switchWindow(inputGraphs[[counter]]$graph, as.character(counter))

    counter <- counter + 1
    print(counter)
    return(paste(basicStr, counter, sep="", collapse=""))
  })
  
  
})