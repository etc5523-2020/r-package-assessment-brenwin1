#' Launch `covidseasonality` app
#' #'
#' @return A shiny application
#' @export
#'
#' @examples
#' launch_app()
#'
launch_app <- function() {
  # Locates the app that exists in covidseasonality package
  appDir <- system.file("app", package = "covidseasonality")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing covidseasonality.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
