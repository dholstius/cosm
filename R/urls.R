#' feedUrl
#'
#' Construct the URL for a Pachube feed
#'
#' @param feed	feed ID
#'
#' @rdname urls
#' @export
feedUrl <- function(feed) {
	sprintf('http://api.pachube.com/v2/feeds/%s', feed)
}

#' datastreamUrl
#'
#' Construct the URL for a Pachube datastream
#'
#' @param feed	feed ID
#'
#' @rdname urls
#' @export
datastreamUrl <- function(feed, datastream) {
	sprintf('%s/datastreams/%s', feedUrl(feed), datastream)
}