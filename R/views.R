fromCSV <- function(content, header=FALSE, stringsAsFactors=FALSE, ...) {
	object <- read.csv(textConnection(content), 
		header = header, 
		stringsAsFactors = stringsAsFactors, 
		...)
	if ('timestamp' %in% names(object))
		object$timestamp <- decode.ISO8601(object$timestamp)
	return(object)
}

#' feed_detail
#'
#' Fetch data from Cosm
#'
#' @param feed			feed ID
#' @param key			API key
#' @param ...			(optional) query string arguments, of the form key=value
#' @return				a Feed object (inherits from list)
#' @note				pass per_page=1000 to get the maximum number of results
#' @export
feed_detail <- function(feed, key, ...) {
	url <- feed_url(feed, format='json')
	header <- http_header(key)
	content <- http_get(url, header, ...)
	parsed <- fromJSON(content)
	object <- Feed(parsed)
	return(object)
}

#' feed_history
#'
#' Fetch datapoints from a given feed or datastream
#'
#' @inheritParams 		feed_detail
#' @param datastreams	datastream ID or IDs (optional; if none supplied will return all)
#' @return				zoo object, or NULL if empty
#' @export
feed_history <- function(feed, key, datastreams, ...) {
	require(zoo)
	args <- list(url=feed_url(feed), header=http_header(key, accept='text/csv'), ...)
	if (!missing(datastreams)) {
		args <- c(datastreams=paste(datastreams, collapse=','), args)
	}
	content <- do.call('http_get', args)
	if (content == "") {
		return(NULL)
	}
	long <- fromCSV(content, col.names=c('datastream', 'timestamp', 'value'))
	wide <- reshape(long, direction='wide', timevar='datastream', idvar='timestamp', v.names='value')
	colnames(wide) <- sub("^value.", "", names(wide))
	object <- Datapoints(wide)
	return(object)
}
