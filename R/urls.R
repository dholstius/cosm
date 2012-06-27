#' feed_url
#'
#' Construct the URL for a Cosm feed
#'
#' @param feed		feed ID
#' @param format	(optional) "csv", "xml", or "json"
#'
feed_url <- function(feed, format) {
	if (inherits(feed, 'Feed')) {
		ID <- feed$id
	} else {
		ID <- feed
	} 
	url <- sprintf('http://api.cosm.com/v2/feeds/%s', ID)
	if (!missing(format))
		url <- paste(url, format, sep='.')
	return(url)
}

#' datastream_url
#'
#' Construct the URL for a Cosm datastream
#'
#' @param feed			feed ID
#' @param datastream	datastream ID
#'
datastream_url <- function(feed, datastream) {
	sprintf('%s/datastreams/%s', feed_url(feed), datastream)
}