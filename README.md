
<!-- README.md is generated from README.Rmd. Please edit that file -->

# showpackage

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/showpackage)](https://cran.r-project.org/package=showpackage)
[![CRAN\_Download\_Badge](http://cranlogs.r-pkg.org/badges/showpackage)](https://CRAN.R-project.org/package=showpackage)
[![CRAN\_Download\_Badge](http://cranlogs.r-pkg.org/badges/grand-total/showpackage)](https://CRAN.R-project.org/package=showpackage)
![R-CMD-check](https://github.com/RobertMyles/showpackage/workflows/R-CMD-check/badge.svg)
<!-- badges: end -->

showpackage is an R package for quickly showing package information like
[`pip show`](https://pip.pypa.io/en/stable/reference/pip_show/) does for
Python. It is *not* a package manager like miniCRAN,
[jetpack](https://github.com/ankane/jetpack),
[packrat](https://rstudio.github.io/packrat/) or any of those packages,
and is not intended to be.

## Installation

``` r
install.packages("showpackage")
```

or

``` r
remotes::install_github("robertmyles/showpackage")
```

## Usage

showpackage is designed for when you need to check package information
quickly, from inside R or from the command line. You can use it inside R
like any regular package, to use it at the command line, run
`showpackage::cli()` first.

Imagine you are installing R on a server without internet access and
need to document package dependencies to maintain the outward
tranquility of your lovely DevOps team members. With showpackage, it’s
easy. For example, we may want to double-check that
[data.table](https://github.com/Rdatatable/data.table) has no external
dependencies. From the terminal on Mac, for example:

``` bash
showpackage data.table
```

The result is:

    $ showpackage data.table
    Package: data.table
    Version: 1.12.8
    Depends: R (>= 3.1.0)
    Imports: methods
    LinkingTo: None
    Description: Fast aggregation of large data (e.g. 100GB in RAM), fast ordered joins, fast add/modify/delete of columns by group using no copies at all, list columns, friendly and fast character-separated-value read/write. Offers a natural and flexible syntax, for faster development.
    Maintainer: Matt Dowle 
    Maintainer Email: mattjdowle@gmail.com
    Homepage: http://r-datatable.com, https://Rdatatable.gitlab.io/data.table,
    https://github.com/Rdatatable/data.table
    Required by: splitstackshape
    Location: /Library/Frameworks/R.framework/Versions/3.6/Resources/library/data.table

Since R is not an external dependency, and neither is
[methods](https://stat.ethz.ch/R-manual/R-devel/library/methods/html/methods-package.html),
we can see that we were right about data.table.

You can also see that a package I’m using,
[splitstackshape](https://cran.r-project.org/package=splitstackshape),
relies on data.table. showpackage allows us to see how many of our
installed packages depend on a certain package. Let’s see how it is for
[Rcpp](https://CRAN.R-project.org/package=Rcpp):

    $ showpackage Rcpp
    Package: Rcpp
    Version: 1.0.3
    Depends: R (>= 3.0.0)
    Imports: methods, utils
    LinkingTo: None
    Description: The 'Rcpp' package provides R functions as well as C++ classes which
    offer a seamless integration of R and C++. Many R data types and objects can be
    mapped back and forth to C++ equivalents which facilitates both writing of new
    code as well as easier integration of third-party libraries. Documentation
    about 'Rcpp' is provided by several vignettes included in this package, via the
    'Rcpp Gallery' site at <http://gallery.rcpp.org>, the paper by Eddelbuettel and
    Francois (2011, <doi:10.18637/jss.v040.i08>), the book by Eddelbuettel (2013,
    <doi:10.1007/978-1-4614-6868-4>) and the paper by Eddelbuettel and Balamuta (2018,
    <doi:10.1080/00031305.2017.1375990>); see 'citation("Rcpp")' for details.
    Maintainer: Dirk Eddelbuettel 
    Maintainer Email: edd@debian.org
    Homepage: http://www.rcpp.org, http://dirk.eddelbuettel.com/code/rcpp.html,
    https://github.com/RcppCore/Rcpp
    Required by: anytime, bindrcpp, dplyr, fs, ggrepel, haven, htmltools, httpuv, hunspell, isoband, later, lubridate, magick, pander, plyr, promises, readr, readxl, reshape2, reticulate, roxygen2, sf, strex, tidyr, units, xml2
    Location: /Library/Frameworks/R.framework/Versions/3.6/Resources/library/Rcpp

The `Required-by` field shows us that quite a lot of the packages I’ve
installed utilise Rcpp.

### Inside R

showpackage can be used from inside R too, which gives you the option of
saving this info as a dataframe, should you want to. An example of both
options:

``` r
show_pkg("ggplot2", return_value = "data") %>% 
  as_tibble() # just for pretty printing
#> # A tibble: 1 x 9
#>   Package Version Depends Imports LinkingTo URL   Description Maintainer
#>   <chr>   <chr>   <chr>   <chr>   <chr>     <chr> <chr>       <chr>     
#> 1 ggplot2 3.3.0.… R (>= … "diges… <NA>      http… "A system … "Hadley W…
#> # … with 1 more variable: MaintainerEmail <chr>
```

Or:

``` r
show_pkg("ggplot2")
#> Package: ggplot2
#> Version: 3.3.0.9000
#> Depends: R (>= 3.2)
#> Imports: digest, glue, grDevices, grid, gtable (>= 0.1.1), isoband, MASS, mgcv,
#> rlang (>= 0.3.0), scales (>= 0.5.0), stats, tibble, withr (>= 2.0.0)
#> LinkingTo: None
#> Description: A system for 'declaratively' creating graphics,
#> based on "The Grammar of Graphics". You provide the data, tell 'ggplot2'
#> how to map variables to aesthetics, what graphical primitives to use,
#> and it takes care of the details.
#> Maintainer: Hadley Wickham 
#> Maintainer Email: hadley@rstudio.com
#> Homepage: http://ggplot2.tidyverse.org, https://github.com/tidyverse/ggplot2
#> Required by: cowplot, crosstalk, fabletools, feasts, ggfiserv, patchwork, tidyverse, ggrepel
#> Location: /Library/Frameworks/R.framework/Versions/3.6/Resources/library/ggplot2
```

## Inspiration

Python’s `pip show` is really useful for quickly getting information for
a particular package. R has a few tools for getting information on
packages: `installed.packages()`; `tools::dependsOnPkgs()`;
`packageVersion()`; `tools::package_dependencies()` as well as the
package manager packages mentioned above; it also has [great
tools](https://CRAN.R-project.org/package=pkgnet) for [plotting
networks](https://eranraviv.com/r-tips-and-tricks-package-dependencies/)
of the dependencies between packages. All wonderful tools, but nothing
that does exactly what `pip show` does, which is something I really like
and appreciated when I needed it for getting Python package
dependencies. Here’s a comparison of `pip show` and `showpackage`:

`pip show pandas` does:

``` bash
Name: pandas
Version: 0.24.2
Summary: Powerful data structures for data analysis, time series, and statistics
Home-page: http://pandas.pydata.org
Author: None
Author-email: None
License: BSD
Location: /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages
Requires: numpy, python-dateutil, pytz
```

`showpackage zoo` does:

``` bash
Package: zoo
Version: 1.8-6
Depends: R (>= 3.1.0), stats
Imports: utils, graphics, grDevices, lattice (>= 0.20-27)
LinkingTo: None
Description: An S3 class with methods for totally ordered indexed
observations. It is particularly aimed at irregular time series
of numeric vectors/matrices and factors. zoo's key design goals
are independence of a particular index/date/time class and
consistency with ts and base R by providing methods to extend
standard generics.
Maintainer: Achim Zeileis
Maintainer Email: Achim.Zeileis@R-project.org
Homepage: http://zoo.R-Forge.R-project.org/
Required by: CausalImpact, dygraphs, forecast, tseries, TTR, bsts, lmtest, quantmod, xts
Location: /Library/Frameworks/R.framework/Versions/3.6/Resources/library/zoo
```

## Thanks

Big thanks to [Andrew Kane](https://github.com/ankane), who made
jetpack. I followed similar logic to get a command line interface for
showpackage.

## See also

  - [pkgnet](https://CRAN.R-project.org/package=pkgnet)
  - [miniCRAN](https://CRAN.R-project.org/package=miniCRAN/)
  - [jetpack](https://CRAN.R-project.org/package=jetpack/)
  - [packrat](https://CRAN.R-project.org/package=packrat/)
