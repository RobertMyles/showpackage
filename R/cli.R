#' Install the command line interface
# Inspired by: https://github.com/ankane/jetpack/blob/master/R/cli.R
#' @param file The file to create
#' @export
#' @examples \dontrun{
#'
#' showpackage::cli()
#' }
cli <- function() {
  if (isWindows()) {
    file <- "C:/ProgramData/showpackage/bin/showpackage.cmd"
    rscript <- file.path(R.home("bin"), "Rscript.exe")
    dir <- dirname(file)
    if (!file.exists(dir)) {
      dir.create(dir, recursive=TRUE)
    }
    write(paste0("@", rscript, " -e \"showpackage::run()\" %* "), file = file)
    message(paste("Wrote", windowsPath(file)))
    message(paste0("Be sure to add '", windowsPath(dir), "' to your PATH"))
  } else {
    file <- "/usr/local/bin/showpackage"
    write("#!/usr/bin/env Rscript\n\nshowpackage::run()", file = file)
    Sys.chmod(file, "755")
    message(paste("Wrote", file))
  }
}

windowsPath <- function(path) {
  gsub("/", "\\\\", path)
}
