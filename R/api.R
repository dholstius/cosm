#' getFeed
#'
#' Fetch data from Pachube
#'
#' @param feed			feed ID
#' @param key			API key
#' @param ...			(optional) query string arguments, of the form key=value
#' @return				a Feed object (inherits from list)
#' @note				pass per_page=1000 to get the maximum number of results
#' @rdname get
#' @export
getFeed <- function(feed, key, ...) {
	url <- feedUrl(feed)
	header <- httpHeader(key)
	content <- httpGet(url, header, ...)
	parsed <- fromJSON(content)
	object <- as.Feed(parsed)
	class(object) <- addClass(object, 'Feed')
	return(object)
}

#' getDatapoints
#'
#' Fetch just the datapoints from a given datastream
#'
#' @param datastream	datastream ID
#' @return				a zoo object
#' @rdname get
#' @export
getDatapoints <- function(feed, datastream, key, ...) {
	url <- datastreamUrl(feed, datastream)
	header <- httpHeader(key, accept='text/csv')
	content <- httpGet(url, header, ...)
	data <- fromCSV(content, col.names=c('timestamp', 'value'))
	z <- with(data, zoo(value, timestamp))
	class(z) <- addClass(z, 'Datapoints')
	return(z)
}
