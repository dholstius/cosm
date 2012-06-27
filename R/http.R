#' http_header
#'
#' Construct an object to serve as a request header in an RCurl call
#'
#' @param key		Cosm API key
#' @param accept	text/csv, application/json, etc.
#' @return			list object
#' @export
http_header <- function(key, accept) {
	object <- list()
	if (!missing(accept))
		object[["Accept"]] <- accept
	if (!missing(key))
		object[["X-ApiKey"]] <- key
	return(object)
}

#' http_get
#'
#' Wrapper for similar RCurl methods
#'
#' @param url		Cosm url (see \link{feed_url})
#' @param header	see \link{http_header}
#' @param curl		curl handle (reusable if making multiple calls)
#' @param per_page	maximum number of results (pass page=2 to fetch more)
#' @param ...		additional key-value pairs (see http://cosm.com/docs/)
#' @return			character
#' @export
http_get <- function(url, header, curl=getCurlHandle(), ..., per_page=1000) {
	if (missing(...)) {
		getURLContent(url, httpheader=header)	
	} else {
		# ISO8601-encode any timestamp arguments, then call RCurl::getForm()
		args <- list(uri=url, ..., curl=curl, per_page=per_page, .opts=list(httpheader=header))
		is.timestamp <- function(x) inherits(x, c('POSIXct', 'POSIXlt'))
		i <- sapply(args, is.timestamp)
		args[i] <- lapply(args[i], encode.ISO8601)
		do.call('getForm', args)
	}
}