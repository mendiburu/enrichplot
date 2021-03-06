##' @rdname heatplot
##' @exportMethod heatplot
setMethod("heatplot", signature(x = "enrichResult"),
          function(x, showCategory = 30, foldChange = NULL) {
              heatplot.enrichResult(x, showCategory, foldChange)
          })

##' @rdname heatplot
##' @exportMethod heatplot
setMethod("heatplot", signature(x = "gseaResult"),
          function(x, showCategory = 30, foldChange = NULL) {
              heatplot.enrichResult(x, showCategory, foldChange)
          })



##' @rdname heatplot
##' @importFrom ggplot2 geom_tile
##' @importFrom ggplot2 theme_minimal
##' @importFrom ggplot2 theme
##' @importFrom ggplot2 element_blank
##' @importFrom ggplot2 element_text
##' @author Guangchuang Yu
heatplot.enrichResult <- function(x, showCategory=30, foldChange=NULL) {
    n <- update_n(x, showCategory)
    geneSets <- extract_geneSets(x, n)

    foldChange <- fc_readable(x, foldChange)
    d <- list2df(geneSets)

    if (!is.null(foldChange)) {
        d$foldChange <- foldChange[d[,2]]
        palette <- fc_palette(d$foldChange)
        p <- ggplot(d, aes_(~Gene, ~categoryID)) +
            geom_tile(aes_(fill = ~foldChange), color = "white") +
            scale_fill_continuous(low="red", high="blue", name = "fold change")
        ## scale_fill_gradientn(name = "fold change", colors = palette)

    } else {
        p <- ggplot(d, aes_(~Gene, ~categoryID)) + geom_tile(color = 'white')
    }
    p + xlab(NULL) + ylab(NULL) + theme_minimal() +
        theme(panel.grid.major = element_blank(),
              axis.text.x=element_text(angle = 60, hjust = 1))
}

