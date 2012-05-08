addClass <- function(object, x) unique(c(class(object), x))

update.list <- function(object, ...) {
	args <- list(...)
	for (key in names(args))
		object[[key]] <- args[[key]]
	return(object)
}

fromCSV <- function(content, header=FALSE, stringsAsFactors=FALSE, ...) {
	object <- read.csv(textConnection(content), 
		header = header, 
		stringsAsFactors = stringsAsFactors, 
		...)
	if ('timestamp' %in% names(object))
		object$timestamp <- decode.ISO8601(object$timestamp)
	return(object)
}

as.Datapoints <- function(object) {
	if (!is.null(object)) {
		values <- sapply(object, '[[', id='value')
		timestamps <- sapply(object, '[[', id='at')
		object <- zoo(values, decode.ISO8601(timestamps))
		class(object) <- addClass(object, 'Datapoints')
	}
	return(object)
}

as.Datastream <- function(object) {
	object$datapoints <- as.Datapoints(object$datapoints)
	class(object) <- addClass(object, 'Datastream')
	return(object)
}

as.Feed <- function(object) {
	object$datastreams <- lapply(object$datastreams, as.Datastream)
	names(object$datastreams) <- sapply(object$datastreams, '[[', i='id')
	class(object) <- addClass(object, 'Feed')
	return(object)
}