update.list <- function(object, ...) {
	args <- list(...)
	for (key in names(args))
		object[[key]] <- args[[key]]
	return(object)
}

parse.named <- function(pattern, x) {
	tryCatch({
		matches <- regexpr(pattern, x, perl=TRUE)
		f <- function(i) {
			if(matches[i] == -1) return("")
			st <- attr(matches, "capture.start")[i, ]
			substring(x[i], st, st + attr(matches, "capture.length")[i, ] - 1)
		}
		m <- do.call(rbind, lapply(seq_along(matches), f))
		if (is.null(m)) {
			return(NULL)
		} else {
			colnames(m) <- attr(matches, "capture.names")
			return(m)
		}
	}, error = function(e) {
		warning("Sorry, couldn't match pattern ", pattern, " to ", x)
		stop(e)
	})
}