#' Check that data matches the color palette
#'
#'
#'
#' @param names.dat vector of data identifiers. For example, the column of taxa names
#' @param palette.name Name of the palette. See `make_colorvec()` for options
#' @param vis.flag If true, make a geom_tile object to visualize the colors to be used for the data.
#'
#' @return optionally, a ggplot object visualizing the color palette as applied to the data.
#' @export
#'
#' @examples
#' dat = data.frame(vals = rnorm(4), species = c("acremonium", "aspergillus", "candida", "vibrio"))
#' palette_check(dat$species, "wolfe2014")
#' # Now with a new taxa not in the palette (because it's common milkweed).
#' dat = data.frame(vals = rnorm(5), species = c("acremonium", "aspergillus", "candida", "vibrio", "Asclepias syriaca"))
#' palette_check(dat$species, "wolfe2014", vis.flag = TRUE)

palette_check = function(names.dat, palette.name, vis.flag = FALSE){
  stopifnot(is.character(names.dat),
            is.logical(vis.flag))
  col.vec = make_colorvec(palette.name)
  if(all(unique(names.dat) %in% names(col.vec))){
    cat("All data identifiers represented in this palette. Nice work!")
  }else{
    cat("Some data identifiers are not present in the palette.",
        "data identifiers without colors:",
        unique(names.dat)[! unique(names.dat) %in% names(col.vec)],
        "",
        "data identifiers in this palette:",
        names(col.vec),
        "",
        "(note that R needs exact spelling + capitalization match. Check for typos!)",
        "(in development: function to add new colors to the palettes for new taxa etc)",
        sep = "\n")
  }
  if(vis.flag){
    palette_vis_(col.vec[names(col.vec) %in% unique(names.dat)])
  }
}
