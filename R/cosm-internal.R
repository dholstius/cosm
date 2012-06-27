update.list <- function(object, ...) {
	args <- list(...)
	for (key in names(args))
		object[[key]] <- args[[key]]
	return(object)
}