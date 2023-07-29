cran_pkgs <- c("remotes",
  "BiocManager",
  "tidyverse",
  "igraph",
  "Seurat",
  "svglite",
  "circlize",
  "reactable",
  "shinyWidgets",
  "shinyFeedback",
  "shinycssloaders",
  "rclipboard",
  "ggthemes",
  "ragg",
  "devtools",
  "DT",
  "plotly"
)
bioc_pkgs <- c("multtest",
  "ComplexHeatmap",
  "tradeSeq",
  "biomaRt",
  "topGO",
  "glmGamPoi",
  "DESeq2"
)
remotes_pkgs=c("thomasp85/patchwork")

cran_pkgs2 <- c("qqconf",
  "metap",
  "akima",
  "ranger",
  "dynutils",
  "dynparam",
  "dyndimred",
  "GA",
  "vipor",
  "ggforce",
  "ggraph",
  "tidygraph",
  "shinyjs",
  "VGAM",
  "hdf5r"
)

lapply(cran_pkgs, function(y) {
  if (!requireNamespace(y, quietly = TRUE)) {
    install.packages(y)
    if (!requireNamespace(y))
      quit(status = 10)
  }
})

lapply(bioc_pkgs, function(y) {
  if (!requireNamespace(y, quietly = TRUE)) {
    BiocManager::install(y)
    if (!requireNamespace(y))
      quit(status = 10)
  }
})

lapply(cran_pkgs2, function(y) {
  if (!requireNamespace(y, quietly = TRUE)) {
    install.packages(y)
    if (!requireNamespace(y))
      quit(status = 10)
  }
})


lapply(remotes_pkgs, function(y) {
  remotes::install_github(y)
})
