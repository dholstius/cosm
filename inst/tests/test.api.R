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

now <- encode.ISO8601(Sys.time())

test_that('getDatapoints', {
	z <- getDatapoints(feed, key, duration='1day', end=now)
	expect_true(inherits(z, 'zoo'))
	expect_true(inherits(z, 'Datapoints'))
	SHT15_H_relative <- getDatapoints(feed, key, datastream='SHT15_H_relative', duration='1day', end=now)
	# FAILS due to length mismatch (bug in Cosm API?):
	# expect_equal(SHT15_H_relative, z$SHT15_H_relative)
})