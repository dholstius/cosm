context('API')

feed <- '57883'
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'

test_that('feedUrl', {
	url <- feedUrl(feed, format='csv')
	expect_equal(url, 'http://api.pachube.com/v2/feeds/57883.csv')
})

test_that('getFeed', {
	info <- getFeedInfo(feed, key)
	expect_true(is.list(info))
})

datastream <- 'Temperature'

test_that('getDatapoint', {
	latest <- getDatapoint(feed, datastream, key)
})

test_that('queryDatastream', {
	history <- queryDatastream(feed, datastream, key, 
		start = encode.ISO8601(Sys.time() - 3600), 
		interval = 60)
	show(tail(history))
})
