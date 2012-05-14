#' encode.ISO8601
#'
#' @param x		a POSIX object
#' @param ...	further arguments to strftime
#'
#' @export
encode.ISO8601 <- function(x, ...) {
	strftime(x, format=.ISO8601, ...)	
}

#' decode.ISO8601
#'
#' @param x		a character object
#' @param ...	further arguments to strptime
#'
#' @export
decode.ISO8601 <- function(x, ...) {
	parse.named <- function(res, result) {
		f <- function(i) {
			if(result[i] == -1) return("")
			st <- attr(result, "capture.start")[i, ]
			substring(res[i], st, st + attr(result, "capture.length")[i, ] - 1)
		}
		m <- do.call(rbind, lapply(seq_along(res), f))
		if (is.null(m)) {
			return(NULL)
		} else {
			colnames(m) <- attr(result, "capture.names")
			return(m)
		}
	}
	pattern <- '(?<date>[0-9]{4}-[0-9]{2}-[0-9]{2})T(?<time>[0-9]{2}:[0-9]{2}:[.0-9]+)(?<offset>[-+:0-9Z]*)'
	parts <- parse.named(x, regexpr(pattern, x, perl=TRUE))
	if (is.null(parts)) {
		return(NULL)
	} else {
		cleaned <- with(as.data.frame(parts), paste(date, 'T', time, sub('Z', '+0000', sub(':', '', offset)), sep=''))
		return(strptime(cleaned, format=.ISO8601, ...))
	}
}
