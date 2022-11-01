#' Iteratively develop augment dataframe for a palette
#'
#' In many cases we will have some of our taxa represented in an existing palette, but may have some new taxa that are not.
#' In this case, we can create an "augment" dateframe to augment the palette with the missing data.
#' These augments can be provided directly to `scale_color_wolfe()` and `scale_fill_wolfe()`, but making them can be a bit of a bother
#' This function helps iterate through that process. See more details in the readme.
#'
#' @param dat.names Character vector of the taxa present in the data.
#' @param augment Data frame to augment palette with. Must have two named columns: "name" contains the names of the taxa spelled exactly like in the data, "color" has the associated colors. If not provided, `palette_augment_helper()` just compares the data to the palette.
#' @param palette.name Optional name of palette to augment. If not given, `palette_augment_helper()` just compares the augment with the data, which is useful for developing new palettes from scrach
#' @param spellcheck Logical flag for whether or not to provide the names of the palette + augment. Useful for checking for typos between data and palette/augment. But this can take up a lot of screen space: set to FALSE to reduce the printout.
#' @param plot.palette Logical flag, defaults to TRUE. If FALSE, `palette_augment_helper()` does not plot the joint palette+augment visualization
#' @param verbose Logical flag, defaults to TRUE. If false, there is no printed output for successful run. Leave to TRUE unless you have a good reason not to (e.g. when using as an internal check in `scale_color_wolfe()`).
#'
#' @return logical, TRUE if the augment works perfectly with the data and palette (if provided), false otherwise. Can be used for internal checks before including augment.
#' @export
#'
#' @examples
#' dat = data.frame(spec = c("arthrobacter", "yaniella", "vibrio", "asclepias", "drosophila"),
#' vals = rnorm(5))
#'
#' ## first attempt at our augment:
#' aug = data.frame(name = c("asclepias", "vibrio"),
#'                  color = c("coral", "blue"))
#'
#' palette_augment_helper(dat.names=dat$spec,
#'                        palette.name = "wolfe2014",
#'                        augment = aug)

palette_augment_helper = function(dat.names,
                                  augment = NULL,
                                  palette.name = NULL,
                                  spellcheck = TRUE,
                                  plot.palette = TRUE,
                                  verbose =TRUE
){
  stopifnot(ncol(augment)==2 | is.null(augment),
            names(augment)==c("name","color")| is.null(augment),
            is.character(palette.name) | is.null(palette.name))
  status.good = TRUE #flag for good status
  col.vec = NULL # vector store colors in
  if(!is.null(palette.name)){
    col.vec = c(col.vec, make_colorvec(palette.name))
  }
  if(!is.null(augment)){
    if(!all(!duplicated(augment$name))){
      cat("Duplicated names in augment! problem names:",
          augment$name[duplicated(augment$name)],
          "",
          sep = "\n")
      status.good = FALSE
    }
    new.vec = augment$color
    names(new.vec) = augment$name
    if(any(names(new.vec) %in% names(col.vec))){
      cat("We have a conflict in names between the palette\n and the proposed augmentations! Duplicated names:",
          names(new.vec)[names(new.vec) %in% names(col.vec)],"", sep = '\n')
      status.good = FALSE
    }
    col.vec = c(col.vec, new.vec)
  }
  if(!all(unique(dat.names) %in% names(col.vec))){
    cat("We are missing colors for the following names:",
        sort((unique(dat.names))[!(unique(dat.names) %in% names(col.vec))]),
        "",
        sep = '\n')
    status.good = FALSE
  }
  if(spellcheck & !status.good){
    cat("We have the following names already (check spelling mismatches!):",
        sort(names(col.vec)),
        "",
        sep = "\n")
  }
  if(plot.palette & !is.null(col.vec)){
    cols.use = col.vec[names(col.vec) %in% dat.names]
    gp = palette_vis_(cols.use)+ggtitle("Augmented palette (as relevant to the data)")
    print(gp)
  }
  if(status.good & verbose){
    cat("Everything looks good!",
        "Augment plus palette span all observed names, no duplicated names in augment, no duplicated names between augment and palette.",
        "Ready for use! Nice work!","",
        sep = "\n")
  }
  return(status.good)
}
