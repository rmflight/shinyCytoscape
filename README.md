# shinyCytoscape

Use RStudio's `shiny` package to create a web-interface that controls which types of graphs are displayed in `Cytoscape`. 

Requires that you have installed `shiny`, `RCytoscape` and their dependencies, as well as `Cytoscape` 2.8 and the `CytoscapeRPC` plugin.

To use:
* clone, download, pull this repo to a local directory
* start `Cytoscape` and initialize the `CytoscapeRPC` plugin with default settings
* in `R`, navigate to the directory with the downloaded files
* run the following code

```
library(shiny)
runApp()
```
