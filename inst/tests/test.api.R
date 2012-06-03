context('API')

feed <- '57883'
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'

test_that('getFeed', {
	object <- getFeed(feed, key)
	expect_true(is.list(object))
	expect_true(inherits(object, 'list'))
	expect_true(inherits(object, 'Feed'))
	expect_equal(object$location$name, 'Berkeley, CA')
})

datastream <- 'SHT15_H_relative'
now <- encode.ISO8601(Sys.time())

test_that('getDatapoints', {
	z <- getDatapoints(feed, datastream, key, duration='1day', end=now)
	expect_true(inherits(z, 'zoo'))
	expect_true(inherits(z, 'Datapoints'))
})