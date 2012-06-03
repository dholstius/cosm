#' parse.named
#'
#' Extract named groups via regex
#'
#' @param pattern	regular expression
#' @param x			character vector
#' @return			NULL if no matches
#' @export
parse.named <- function(pattern, x) {
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
}