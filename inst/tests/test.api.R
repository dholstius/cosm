context('API')

ID <- '57883'
key <- Sys.getenv('COSM_API_KEY')
stopifnot(key != "")

t0 <- ISOdate(2012, 06, 01)

test_that('getFeed works', {
	object <- getFeed(feed, key)
	expect_true(is.list(object))
	expect_true(inherits(object, 'list'))
	expect_true(inherits(object, 'Feed'))
	expect_equal(object$location$name, 'Berkeley, CA')
})

test_that('getDatapoints returns all datastreams by default', {
	object <- getDatapoints(feed, key, start=t0, duration='1hour')
	expect_true(inherits(object, 'xts'))
	expect_true(inherits(object, 'Datapoints'))
	expect_true(length(colnames(object)) > 4)
	datastreams <- names(getFeed(feed, key)$datastreams)
	expect_true(all(colnames(object) %in% datastreams))
})

test_that('getDatapoints returns selected datastreams', {
	datastreams <- c('SHT15_H_relative', 'SHT15_H_raw')
	object <- getDatapoints(feed, key, datastreams=datastreams, start=t0, duration='1hour')
	expect_equal(colnames(object), datastreams)
})