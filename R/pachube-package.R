require(RCurl)
require(rjson)

.ISO8601 <- "%Y-%m-%dT%H:%M:%OS%z"

if (is.null(getOption('digits.secs'))) {
	message('Use options(digits.secs = 6) to get/set fractional seconds')
}
