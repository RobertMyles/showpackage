#' @title Show Package Details
#' @description Prints or returns information on a certain package.
#' @importFrom utils installed.packages
#' @importFrom docopt docopt
#' @param package Name of package.
#' @param lib_path Default is \code{.libPaths()}, custom path to packages 
#' can be specified.
#' @param return_value One of "print" (prints out the results to the 
#' R console) or "data" (returns the results as a dataframe).
#' @examples 
#' show_pkg("MASS")
#' @export
show_pkg <- function(package = NULL, lib_path = NULL, 
                     return_value = c("print", "data")){
  # checks
  if (is.null(lib_path)) lib_path <- .libPaths()
  if(is.null(package)) stop("Please specifiy a package.")
  # args
  return_val <- match.arg(return_value, choices = c("print", "data"))
  fields <- c("Package", "Version", "Depends", "Imports", "LinkingTo",
              "URL", "Description", "Maintainer")
  # get package 
  pkgs <- list.files(lib_path)
  pkg_check <- package %in% pkgs
  if(pkg_check) {
    pkg_desc <- file.path(lib_path, package, "DESCRIPTION")
    pkg_path <- file.path(lib_path, package)
  }
  # get package details
  desc <- tryCatch(read.dcf(pkg_desc, fields = fields),
                   error = identity)
  desc <- as.data.frame(desc, stringsAsFactors = FALSE)
  desc$MaintainerEmail <- strsplit(desc$Maintainer, split = "<")[[1]][[2]]
  desc$MaintainerEmail <- gsub(">", "", x = desc$MaintainerEmail)
  desc$Maintainer <- strsplit(desc$Maintainer, split = "<")[[1]][[1]]
  desc$Maintainer <- gsub("<", "", x = desc$Maintainer)
  
  # get 'required-by':
  x <- installed.packages(lib.loc = lib_path)
  x <- as.data.frame(x, stringsAsFactors = FALSE)
  req1 <- x$Package[grep(package, x$Imports)]
  req2 <- x$Package[grep(package, x$Depends)]
  required_by <- append(req1, req2)
  required_by <- paste0(required_by, collapse = ", ")
  
  ## filter Imports and depends to find package
  if(return_val == "data"){
    return(desc)
  } else{
    # format output
    
    none_format <- function(x){
      res <- ifelse(!is.na(x), x, "None")
    }
    
    return_string <- paste0(
      "Package: ", none_format(desc$Package), "\n",
      "Version: ", none_format(desc$Version), "\n",
      "Depends: ", none_format(desc$Depends), "\n",
      "Imports: ", none_format(desc$Imports), "\n",
      "LinkingTo: ", none_format(desc$LinkingTo), "\n",
      "Description: ", none_format(desc$Description), "\n",
      "Maintainer: ", none_format(desc$Maintainer), "\n",
      "Maintainer Email: ", none_format(desc$MaintainerEmail), "\n",
      "Homepage: ", none_format(desc$URL), "\n",
      "Required by: ", required_by, "\n",
      "Location: ", pkg_path 
    )
    cat(return_string)
  }
}
