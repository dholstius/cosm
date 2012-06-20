require(RCurl)
require(rjson)
require(zoo)

if (is.null(getOption('digits.secs'))) {
	message('Set options(digits.secs=3) for millisecond precision')
}
