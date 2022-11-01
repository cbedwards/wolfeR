#' Visualize the colors for a given palette, internal function
#'
#' Takes a color vector (rather than palette name) to visualize with geom_tile. Used in `palette_vis()`, also useful for development/experimenting.
#'
#' @param color.vec Named character vector: entries are colors, names are species/identifiers
#'
#' @return A ggplot object showing color tiles and associated species/identification names.
#' @export
#' @import ggplot2
#'
#'
#' @examples
#' palette_vis_(c(turtle = 'lightblue', rat = 'coral', ostrich = 'goldenrod3'))

palette_vis_ = function(color.vec){
  maxdim = ceiling(sqrt(length(color.vec)))
  dat.plot = data.frame(name = names(color.vec),
                        x = rep(1:maxdim, length.out = length(color.vec)),
                        y = rep(1:maxdim, each = maxdim)[1:length(color.vec)])
  ggplot(data = dat.plot, aes(x = x, y = y, fill = name))+
    geom_tile()+
    scale_fill_discrete(type = color.vec)+
    geom_text(aes(label = name))
}
