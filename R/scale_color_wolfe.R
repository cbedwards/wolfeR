#' Using wolfeR color palettes in ggplot
#'
#' scale_fill_wolfe is a wrapper for scale_fill_discrete, and can be added to a ggplot object to color tiles and bars appropriately
#' scale_color_wolfe is a wrapper for scale_color_discrete, and can be added to a ggplot object to color points and lines appropriately
#'
#' @details Note that presently these functions are somewhat fragile, and won't handle data well unless the entirety of the taxa are represented in
#' the palette (and spelled/capitalized identically). Use `palette_check()` to check whether this is the case
#' and identify mismatches. In development: a function to easily augment existing color palettes.
#'
#' Note that these functions are designed with a character vector in mind, rather than factors.
#' If they don't seem to be working, make sure your species names aren't factors (`as.character()` is your friend here).
#'
#' @param dat.names vector of the taxa names or other identifiers from the data
#' @param palette.name Name of color palette used, defaults to wolfe2014. See `make_colorvec.R` for details.
#'
#' @return a layer for ggplots to specify either the colors used in fill or
#' @import ggplot2
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' #generate simulated data akin to wolfe lab data for examples
#' dat = as.data.frame(expand.grid(name = c("candida", "vibrio",
#'                                   "brachybacterium"), #species name
#'                                 day = c(1, 3, 7, 14, 21), #day of time series
#'                                 rep = 1:3,#replicate number
#'                                 stringsAsFactors = FALSE))
#' dat$count = 500 + #baseline
#'   100000 * (dat$day>1) +  #population generally gets near carrying capacity
#'   #  after first measurement
#'   (dat$day>1) * -20000*(dat$name == "candida") +#make candida CC lower
#'   (dat$day>1) *  30000*(dat$name == "vibrio") + #make vibrio CC higher
#'   (dat$day>1) * runif(nrow(dat), min = -20000, max = 20000)
#'   # add some random noise to observations except day 1
#' # check the palette
#' palette_check(dat$name, "wolfe2014")
#' #plot the timeseries
#' col.test = make_colorvec()
#' col.test = col.test[names(col.test) %in% dat$name]
#' ggplot(data = dat, aes(x = day,
#'                        y = count,
#'                        group = interaction(name, rep),
#'                        color = name))+
#'   geom_path(size = 0.8)+
#'   geom_point(size = 2)+
#'   scale_y_log10()+
#'   scale_color_wolfe(dat$name, "wolfe2014")+
#'   ggtitle("Simulated time series, 3 replicates per species")
#' ## now to aggregate + make barplot.
#' ## Here we'll imagine we want the mean abundance for each species broken
#' ## down by day
#' dat.summary = dat %>%
#'   group_by(name, day) %>%
#'   summarize(count = mean(count))
#' ggplot(data = dat.summary,
#'        aes(x = name, y = count, fill = name))+
#'   geom_col()+
#'   facet_wrap(~ day)+
#'   scale_fill_wolfe(dat.summary$name, "wolfe2014")+
#'   xlab("")+
#'   ggtitle("Simulated summary data, separated by day of experiment")


scale_color_wolfe = function(dat.names, palette.name = "wolfe2014"){
  stopifnot(is.character(dat.names))
  col.vec = make_colorvec()
  col.vec = col.vec[names(col.vec) %in% dat.names]
  scale_color_discrete(type = col.vec)
}
