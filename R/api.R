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
#' Fetch datapoints from a given feed or datastream
#'
#' @param datastream	datastream ID or IDs (optional; if none supplied will return all)
#' @return				a zoo object
#' @rdname get
#' @export
getDatapoints <- function(feed, key, datastreams, ...) {
	args <- list(url=feedUrl(feed), header=httpHeader(key, accept='text/csv'), ...)
	if (!missing(datastreams)) 
		args <- c(datastreams=paste(datastreams, collapse=','), args)
	content <- do.call('httpGet', args)
	datapoints <- fromCSV(content, col.names=c('datastream', 'timestamp', 'value'))
	wideFormat <- reshape(datapoints, direction='wide', timevar='datastream', idvar='timestamp', v.names='value')
	names(wideFormat)[-1] <- sub("^value.", "", names(wideFormat)[-1])
	z <- zoo(wideFormat[,-1], order.by=wideFormat[,1])
	class(z) <- addClass(z, 'Datapoints')
	return(z)
}
