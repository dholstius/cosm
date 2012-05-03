require(RCurl)

datastreamUrl <- function(feed, datastream, format='csv') {
	sprintf('http://api.pachube.com/v2/feeds/%s/datastreams/%s.%s', feed, datastream, format)
}

feedUrl <- function(feed, format='csv') {
	sprintf('http://api.pachube.com/v2/feeds/%s.%s', feed, format)
}

getFeedInfo <- function(feed, key) {
	require(XML)
	url <- feedUrl(feed, format='xml')
	request.header <- c(`X-PachubeApiKey`=key)
	response.content <- getURLContent(url, httpheader=request.header)
	root <- xmlTreeParse(response.content)
	info <- xmlToList(root$doc$children$eeml)
	return(info)
}

getDatastream <- function(feed, datastream, key) {
	url <- datastreamUrl(feed, datastream, format='csv')
	request.header <- c(`X-PachubeApiKey`=key)
	response.content <- getURLContent(url, httpheader=request.header)
	dat <- read.csv(textConnection(response.content), header=FALSE, stringsAsFactors=FALSE)
	names(dat) <- c('Timestamp', datastream)
	dat <- transform(dat, Timestamp = decode.ISO8601(Timestamp))
	return(dat)
}

queryDatastream <- function(feed, datastream, key, ...) {
	url <- datastreamUrl(feed, datastream, format='csv')
	request.header <- c(`X-PachubeApiKey`=key)
	request.options <- curlOptions(httpheader=request.header)
	response.content <- getForm(url, ..., .opts = request.options)
	dat <- read.csv(textConnection(response.content), header=FALSE, stringsAsFactors=FALSE)
	names(dat) <- c('Timestamp', datastream)
	dat <- transform(dat, Timestamp = decode.ISO8601(Timestamp))
	return(dat)
}