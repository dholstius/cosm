#' feedUrl
#'
#' Construct the URL for a Pachube feed
#'
#' @param feed	feed ID
#'
#' @rdname urls
#' @export
feedUrl <- function(feed, format) {
	url <- sprintf('http://api.pachube.com/v2/feeds/%s', feed)
	if (!missing(format))
		url <- paste(url, format, sep='.')
	return(url)
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