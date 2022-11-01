#' Visualize the colors for a given palette
#'
#' @param palette.name Name of the palette being used, defaulting to "wolfe2014". See help("make_colorvec") for details.
#'
#' @return A ggplot object showing color tiles and associated species/identification names.
#' @export
#' @import ggplot2
#'
#' @examples
#' palette_vis("wolfe2014")

palette_vis = function(palette.name){
  col.vec = make_colorvec(palette.name)
  palette_vis_(col.vec)
}
