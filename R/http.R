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
httpGet <- function(url, header, ...) {
	if (missing(...)) {
		getURLContent(url, httpheader=header)	
	} else {
		getForm(url, ..., .opts=list(httpheader=header))
	}
}