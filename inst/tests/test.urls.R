context('URLs')

feed <- '57883'

test_that('feed_url constructs correct URL', {
	url <- feed_url(feed)
	expect_equal(url, 'http://api.cosm.com/v2/feeds/57883')
})

datastream <- 'small'

test_that('datastream_url constructs correct URL', {
	url <- datastream_url(feed, datastream)
	expect_equal(url, 'http://api.cosm.com/v2/feeds/57883/datastreams/small')
})
