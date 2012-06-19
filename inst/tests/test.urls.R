context('URLs')

feed <- '57883'
test_that('feedUrl', {
	url <- feedUrl(feed)
	expect_equal(url, 'http://api.cosm.com/v2/feeds/57883')
})

datastream <- 'PM_Small'
test_that('datastreamUrl', {
	url <- datastreamUrl(feed, datastream)
	expect_equal(url, 'http://api.cosm.com/v2/feeds/57883/datastreams/PM_Small')
})
