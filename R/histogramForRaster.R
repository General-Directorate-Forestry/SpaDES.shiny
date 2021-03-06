#' Histogram for Raster Shiny Module
#'
#' @description A shiny module creating histogram of data contained in a raster.
#'
#' @template id
#'
#' @param title Optional title for the histogram. Any shiny tag can be used.
#'
#' @param plotParameters A list of parameters passed to \code{\link[shiny]{plotOutput}}.
#'
#' @param ... Additional parameters passed to \code{\link[shinydashboard]{box}}
#'            in \code{histogramForRasterUI}, and \code{\link[graphics]{barplot}}
#'            in \code{histogramForRaster}.
#'
#' @return None. Invoked for the side-effect of creating shiny UI.
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom shiny NS plotOutput
#' @importFrom shinycssloaders withSpinner
#' @importFrom shinydashboard box
#' @rdname histogramForRaster
histogramForRasterUI <- function(id, title = "", plotParameters, ...) {
  ns <- NS(id)

  plotParameters["outputId"] <- NULL
  plotOutputParameters <- c(ns("hist4rast"), plotParameters)

  box(title,
      #shinycssloaders::withSpinner(
        do.call(plotOutput, plotOutputParameters)
      #)
      ,
      ...)
}

#' Histogram for Raster Shiny Module
#'
#' @template input
#'
#' @template output
#'
#' @template session
#'
#' @param rctRasterVals Reactive values (likely extracted from a raster)
#'
#' @param scale Number used for scaling heights of histogram bars.
#'              When set to 1 (default) histogram bar height represents the number
#'              of raster cells with value from bar interval.
#'              If the resolution of raster is known, \code{scale} can be used
#'              to transform these heights into the ones representing area covered
#'              by cells (count).
#'              When set to 2 (or, more generally, some number n with no further meaning)
#'              this will just increase the height of each histogram bar by 2
#'              (n, respectively).
#'              So, in this scenario, each histogram's bar height is just count
#'              times 2 (count times n).
#'
#' @param rctHistogramBreaks Reactive value which is responsible for \code{breaks}
#'                        parameter, as in \code{\link[graphics]{hist}}.
#'
#' @param addAxisParams Reactive value with parameters to \code{\link[graphics]{axis}}.
#'                      If \code{NULL} (default) then no axis is drawn.
#'
#' @return None. Invoked for the side-effect of rendering histogram plot.
#'
#' @export
#' @importFrom graphics axis barplot
#' @importFrom shiny renderPlot
#' @importFrom raster hist
#' @rdname histogramForRaster
histogramForRaster <- function(input, output, session, rctRasterVals, rctHistogramBreaks,
                               scale = 1, addAxisParams = NULL,  ...) {
  output$hist4rast <- renderPlot({
    rasVals <- rctRasterVals() %>% as.numeric()
    # rasVals <- if (!is(ras, "Raster")) {
    #   numeric()
    # } else {
    #   ras[]
    # }
    histogram <- graphics::hist(rasVals, plot = FALSE, breaks = rctHistogramBreaks())

    barHeights <- histogram$counts * scale
    dots <- list(...)
    dots$col <- if (!is.null(dots$col)) {
      dots$col[histogram$mids]
    } else {
      NULL
    }

    do.call(barplot, append(list(barHeights), dots))

    if (!is.null(addAxisParams)) {
      axps <- if (is.reactive(addAxisParams)) addAxisParams() else addAxisParams
      do.call(axis, axps)
    }
  })
}
