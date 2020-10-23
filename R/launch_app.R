#' Launch `covidseasonality` app
#' @description Launch covidseasonality Shiny App embedded in the `covidseasonality` downloadable from [GitHub](https://github.com/etc5523-2020/r-package-assessment-brenwin1)
#' @return A shiny application
#' @export
#'
launch_app <- function() {
  # Locates the app that exists in covidseasonality package
  appDir <- system.file("app", package = "covidseasonality")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing covidseasonality.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
