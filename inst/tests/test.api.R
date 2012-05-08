context('API')

feed <- '57883'
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'
d <- ISOdate(2012, 5, 4)
start <- encode.ISO8601(d)

test_that('getFeed', {
	object <- getFeed(feed, key, start=start)
	expect_true(is.list(object))
	expect_true(inherits(object, 'list'))
	expect_true(inherits(object, 'Feed'))
	expect_equal(object$location$name, 'Berkeley, CA')
})

datastream <- 'PM_Small'

test_that('getDatapoints', {
	object <- getDatapoints(feed, datastream, key, start=start)
	expect_true(inherits(object, 'zoo'))
	expect_true(inherits(object, 'Datapoints'))
})