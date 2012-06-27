context('API')

feed <- '57883'
key <- Sys.getenv('COSM_API_KEY')
stopifnot(key != "")

t0 <- ISOdate(2012, 06, 01)

test_that('feed_detail works', {
	detail <- feed_detail(feed, key)
	expect_true(is.list(detail))
	expect_true(inherits(detail, 'list'))
	expect_true(inherits(detail, 'Feed'))
	expect_equal(detail$location$name, 'Berkeley, CA')
})

test_that('feed_history returns all datastreams by default', {
	history <- feed_history(feed, key, start=t0, duration='1hour')
	expect_true(inherits(history, 'zoo'))
	expect_true(inherits(history, 'Datapoints'))
	expect_true(length(colnames(history)) > 4)
	datastreams <- names(feed_detail(feed, key)$datastreams)
	expect_true(all(colnames(history) %in% datastreams))
})

test_that('feed_history returns selected datastreams', {
	datastreams <- c('SHT15_H_relative', 'SHT15_H_raw')
	history <- feed_history(feed, key, datastreams=datastreams, start=t0, duration='1hour')
	expect_equal(colnames(history), datastreams)
	datastreams <- 'SHT15_H_raw'
	history <- feed_history(feed, key, datastreams=datastreams, start=t0, duration='1hour')
})