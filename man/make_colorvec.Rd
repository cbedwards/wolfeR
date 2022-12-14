% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_colorvec.R
\name{make_colorvec}
\alias{make_colorvec}
\title{Returns a color vector based on name}
\usage{
make_colorvec(palette.name = "wolfe2014")
}
\arguments{
\item{palette.name}{Name of the color palette to use. Defaults to "wolfe2014".}
}
\value{
A named character vector, with each entry giving a color,
and the corresponding name giving the associated species or other identifier.
}
\description{
This is the workhorse of the package, storing vectors of names and colors based
on the publications of the wolfe lab. Can be used to get the color vectors directly,
also used internally in more user-friendly functions.
}
\details{
Currently the only color palette supported is "wolfe2014", which is based on the
colors of Figure 2 in Wolfe et al. 2014 (https://doi.org/10.1016/j.cell.2014.05.041).

Adding other color palettes is relatively easy given the list of variable names (e.g. species or strains) and
the associated colors. For extracting colors from published figures, I found https://colors.artyclick.com/color-name-finder/ helpful.
}
\examples{
make_colorvec()
}
