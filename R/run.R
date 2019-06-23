#' Run the command line interface
# Inspired by: https://github.com/ankane/jetpack/blob/master/R/run.R
#' @importFrom docopt docopt
#' @export
#' @keywords internal
run <- function() {

  doc <- "Usage:
    showpackage <package>
    showpackage help"
  
  opts <- NULL
  tryCatch({
    opts <- docopt::docopt(doc)
    }, error = function(err){
    msg <- conditionMessage(err)
    if (!grepl("usage:", msg)) {
      warn(msg)
    }
    message(doc)
    quit(status = 1)
  })
  
  tryCatch({
    if(opts$help){
      message(doc)
      } else{
      show_pkg(package = opts$package)
        }
    }, error=function(err) {
      msg <- conditionMessage(err)
      quit(status = 1)
    })
}
