#' getFeed
#'
#' Fetch data from Cosm
#'
#' @param feed			feed ID
#' @param key			API key
#' @param ...			(optional) query string arguments, of the form key=value
#' @return				a Feed object (inherits from list)
#' @note				pass per_page=1000 to get the maximum number of results
#' @rdname get
#' @export
getFeed <- function(feed, key, ...) {
	url <- feedUrl(feed, format='json')
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
#' @param datastreams	datastream ID or IDs (optional; if none supplied will return all)
#' @return				zoo object, or NULL if empty
#' @rdname get
#' @export
getDatapoints <- function(feed, key, datastreams, ...) {
	require(zoo)
	args <- list(url=feedUrl(feed), header=httpHeader(key, accept='text/csv'), ...)
	if (!missing(datastreams)) {
		args <- c(datastreams=paste(datastreams, collapse=','), args)
	}
	content <- do.call('httpGet', args)
	if (content == "") {
		return(NULL)
	}
	long <- fromCSV(content, col.names=c('datastream', 'timestamp', 'value'))
	wide <- reshape(long, direction='wide', timevar='datastream', idvar='timestamp', v.names='value')
	object <- zoo(wide[,-1], order.by=wide[,1])
	datastreams <- sub("^value.", "", names(wide)[-1])
	if (length(datastreams) > 1) {
		colnames(object) <- datastreams
	}
	class(object) <- addClass(object, 'Datapoints')
	return(object)
}
