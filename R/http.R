#' httpHeader
#'
#' Construct an object to serve as a request header in an RCurl call
#'
#' @param key		Pachube API key
#' @return			a list
#' @rdname http
#' @export
httpHeader <- function(key, accept) {
	object <- list()
	if (!missing(accept))
		object[["Accept"]] <- accept
	if (!missing(key))
		object[["X-PachubeApiKey"]] <- key
	return(object)
}

#' httpGet
#'
#' Wrapper for similar RCurl methods
#'
#' @param url		Pachube url (see \link{feedUrl})
#' @param header	see \link{httpHeader}
#' @return			character
#' @rdname http
#' @export
httpGet <- function(url, header, ..., per_page=1000) {
	if (missing(...)) {
		getURLContent(url, httpheader=header)	
	} else {
		# ISO8601-encode any timestamp arguments, then call RCurl::getForm()
		args <- list(uri=url, ..., per_page=per_page, .opts=list(httpheader=header))
		is.timestamp <- function(x) inherits(x, c('POSIXct', 'POSIXlt'))
		i <- sapply(args, is.timestamp)
		args[i] <- lapply(args[i], encode.ISO8601)
		do.call('getForm', args)
	}
}