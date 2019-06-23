
<!-- README.md is generated from README.Rmd. Please edit that file -->

# showpackage

<!-- badges: start -->

<!-- badges: end -->

showpackage is an R package for quickly showing package information like
[`pip show`](https://pip.pypa.io/en/stable/reference/pip_show/) does for
Python. It is *not* a package manager like miniCRAN,
[jetpack](https://github.com/ankane/jetpack),
[packrat](https://rstudio.github.io/packrat/) or any of those packages,
and is not intended to be.

## Usage

showpackage is designed for when you need to check package information
quickly, from inside R or from the command line. Imagine you are
installing R on a server without internet access and need to see package
dependencies to maintain the outward tranquility of your lovely DevOps
team members. With showpackage, it’s easy. Imagine we want to
double-check that [data.table](https://github.com/Rdatatable/data.table)
has no external dependencies. From the terminal on Mac, for example:

``` bash
showpackage data.table
```

The result is:

![](https://i.imgur.com/GbGx5dM.png)

Since R is not an *external* dependency, and neither is
[methods](https://stat.ethz.ch/R-manual/R-devel/library/methods/html/methods-package.html),
we can see that we were right about data.table.

We can also see how many of our installed packages depend on the package
in question. Let’s see how it is for
[Rcpp](https://CRAN.R-project.org/package=Rcpp):

![](https://i.imgur.com/pGI9GOO.png)

The `Required-by` field shows us that quite a lot of the packages I’ve
installed utilise Rcpp.

### Inside R

showpackagecan be used from inside R too, which gives you the option of
saving this info as a dataframe, should you want to. An example of both
options:

``` r
show_pkg("ggplot2", return_value = "data") %>% 
  as_tibble() # just for pretty printing
#> # A tibble: 1 x 9
#>   Package Version Depends Imports LinkingTo URL   Description Maintainer
#>   <chr>   <chr>   <chr>   <chr>   <chr>     <chr> <chr>       <chr>     
#> 1 ggplot2 3.2.0   R (>= … "diges… <NA>      http… "A system … "Hadley W…
#> # … with 1 more variable: MaintainerEmail <chr>
```

Or:

``` r
show_pkg("ggplot2")
#> Package: ggplot2
#> Version: 3.2.0
#> Depends: R (>= 3.2)
#> Imports: digest, grDevices, grid, gtable (>= 0.1.1), lazyeval, MASS,
#> mgcv, reshape2, rlang (>= 0.3.0), scales (>= 0.5.0), stats,
#> tibble, viridisLite, withr (>= 2.0.0)
#> LinkingTo: None
#> Description: A system for 'declaratively' creating graphics,
#> based on "The Grammar of Graphics". You provide the data, tell 'ggplot2'
#> how to map variables to aesthetics, what graphical primitives to use,
#> and it takes care of the details.
#> Maintainer: Hadley Wickham 
#> Maintainer Email: hadley@rstudio.com
#> Homepage: http://ggplot2.tidyverse.org, https://github.com/tidyverse/ggplot2
#> Required by: bayesplot, brms, CausalImpact, colourpicker, crosstalk, dlstats, forecast, ggiraph, ggridges, rstanarm, shinystan, tidyverse, viridis, cowplot, gganimate, ggrepel, plotly, rstan
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

### But who cares ’bout dependencies?? 😕

[Lots of
people.](http://dirk.eddelbuettel.com/blog/2018/02/28/#017_dependencies)

## Thanks

Big thanks to [Andrew Kane](https://github.com/ankane), who made
jetpack. I followed similar logic to get a command line interface for
showpackage.

## See also

  - [pkgnet](https://CRAN.R-project.org/package=pkgnet)
  - [miniCRAN](https://CRAN.R-project.org/package=miniCRAN/)
  - [jetpack](https://CRAN.R-project.org/package=jetpack/)
  - [packrat](https://CRAN.R-project.org/package=packrat/)
