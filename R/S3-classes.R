#' Feed
#'
#' Informal constructor for a Feed object
#'
#' @param	object	a nested list
#' @export
Feed <- function(object) {
	object$datastreams <- lapply(object$datastreams, Datastream)
	names(object$datastreams) <- sapply(object$datastreams, '[[', i='id')
	class(object) <- union('Feed', class(object))
	return(object)
}

Datastream <- function(object) {
	object$datapoints <- Datapoints(object$datapoints)
	class(object) <- union('Datastream', class(object))
	return(object)
}

Datapoints <- function(object) {
	if (is.null(object)) {
		return(NULL)
	} else if (is.data.frame(object)) {
		index <- which(colnames(object) == 'timestamp')
		object <- zoo(object[,-index], order.by=object[,index])
	} else if (is.list(object)) {
		values <- sapply(object, '[[', id='value')
		timestamps <- sapply(object, '[[', id='at')
		object <- zoo(values, decode.ISO8601(timestamps))
	}
	class(object) <- union('Datapoints', class(object))
	return(object)
}