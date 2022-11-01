#' Returns a color vector based on name
#'
#' This is the workhorse of the package, storing vectors of names and colors based
#' on the publications of the wolfe lab. Can be used to get the color vectors directly,
#' also used internally in more user-friendly functions.
#'
#' @param palette.name Name of the color palette to use. Defaults to "wolfe2014".
#'
#' @return A named character vector, with each entry giving a color,
#' and the corresponding name giving the associated species or other identifier.
#' @export
#'
#' @details
#' Currently the only color palette supported is "wolfe2014", which is based on the
#' colors of Figure 2 in Wolfe et al. 2014 (https://doi.org/10.1016/j.cell.2014.05.041).
#'
#' Adding other color palettes is relatively easy given the list of variable names (e.g. species or strains) and
#' the associated colors. For extracting colors from published figures, I found https://colors.artyclick.com/color-name-finder/ helpful.
#'
#' @examples
#' make_colorvec()

make_colorvec = function(palette.name = "wolfe2014"){
  palette.names = c("wolfe2014") #update as I add palettes
  stopifnot(is.character(palette.name), length(palette.name) == 1, palette.name %in% palette.names)
  ## stop if palette.name isn't in the the list, isn't a vector
  ##
  if(palette.name == "wolfe2014"){
    col.vec = c(staphylococcus = "#009936",
                brevibacterium = "#272B81",
                corynebacterium = "#36A9E1",
                brachybacterium = "#AEDFF8",
                arthrobacter = "#DEF1FF",
                nocardiopsis = "#AB7F95",
                yaniella = "#AB7F95",
                halomonas = "#BD1311",
                psychobacter = "#DA2209",
                pseudomonas = "#E94C13",
                pseudoalteromonas = "#F39100",
                vibrio = "#FCEA0A",
                hafnia = "#FFF6A6",
                serratia = "#FFF6A6", #this and hafnia were the same level
                sphingobacterium = "#9D9D9D",
                debaryomyces = "#12563B",
                galactomyces = "#8B9C62",
                candida = "#CFC64C",
                scopulariopsis = "#A34F10",
                fusarium = "#812845",
                acremonium = "#AF2E16",
                penicillium = "#847976",
                aspergillus = "#DBDBDB",
                sporendonema = "#EE7D15",
                chrysosporium = "#E5BD00",
                missing = "black")
  }
  return(col.vec)
}
