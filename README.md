# shinyCytoscape

Use RStudio's `shiny` package to create a web-interface that controls which types of graphs are displayed in `Cytoscape`. 

To use, clone, download, pull this repo to a local directory. In `R`, navigate to the directory with the downloaded files. 

Requires that you have installed `shiny`, `RCytoscape` and their dependencies, as well as `Cytoscape` 2.8 and the `CytoscapeRPC` plugin.

Start `Cytoscape` and initialize the `CytoscapeRPC` plugin with default settings. Then run the following code in `R`:

```
library(shiny)
runApp()
```
