#' feedUrl
#'
#' Construct the URL for a Cosm feed
#'
#' @param feed		feed ID
#' @param format	(optional) "csv", "xml", or "json"
#'
feedUrl <- function(feed, format) {
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

#' datastreamUrl
#'
#' Construct the URL for a Cosm datastream
#'
#' @param feed			feed ID
#' @param datastream	datastream ID
#'
datastreamUrl <- function(feed, datastream) {
	sprintf('%s/datastreams/%s', feedUrl(feed), datastream)
}