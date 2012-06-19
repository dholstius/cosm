require(RCurl)
require(rjson)

if (is.null(getOption('digits.secs'))) {
	message('Use options(digits.secs = 6) to get/set fractional seconds')
}
