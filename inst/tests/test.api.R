context('API')

feed <- '57883'
key <- Sys.getenv('COSM_API_KEY')
stopifnot(key != "")

t0 <- ISOdate(2012, 06, 01)

test_that('feed_detail works', {
	object <- feed_detail(feed, key)
	expect_true(is.list(object))
	expect_true(inherits(object, 'list'))
	expect_true(inherits(object, 'Feed'))
	expect_equal(object$location$name, 'Berkeley, CA')
})

test_that('feed_history returns all datastreams by default', {
	object <- feed_history(feed, key, start=t0, duration='1hour')
	expect_true(inherits(object, 'zoo'))
	expect_true(inherits(object, 'Datapoints'))
	expect_true(length(colnames(object)) > 4)
	datastreams <- names(feed_detail(feed, key)$datastreams)
	expect_true(all(colnames(object) %in% datastreams))
})

test_that('feed_history returns selected datastreams', {
	datastreams <- c('SHT15_H_relative', 'SHT15_H_raw')
	object <- feed_history(feed, key, datastreams=datastreams, start=t0, duration='1hour')
	expect_equal(colnames(object), datastreams)
	datastreams <- 'SHT15_H_raw'
	object <- feed_history(feed, key, datastreams=datastreams, start=t0, duration='1hour')
})