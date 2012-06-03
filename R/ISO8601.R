ISO8601.format <- "%Y-%m-%dT%H:%M:%OS%z"
ISO8601.pattern <- '(?<date>[0-9]{4}-[0-9]{2}-[0-9]{2})T(?<time>[0-9]{2}:[0-9]{2}:[.0-9]+)(?<offset>[-+:0-9Z]*)'

#' encode.ISO8601
#'
#' @param x		a POSIX object
#' @param ...	further arguments to strftime
#'
#' @export
encode.ISO8601 <- function(x, ...) {
	strftime(x, format=ISO8601.format, ...)	
}

#' decode.ISO8601
#'
#' @param x		a character object
#' @param ...	further arguments to strptime
#'
#' @export
decode.ISO8601 <- function(x, ...) {
	parts <- parse.named(ISO8601.pattern, x)
	if (is.null(parts)) {
		return(NULL)
	} else {
		cleaned <- with(as.data.frame(parts), paste(date, 'T', time, sub('Z', '+0000', sub(':', '', offset)), sep=''))
		datetimes <- strptime(cleaned, format=ISO8601.format, ...)
		return(as.POSIXct(datetimes))
	}
}
