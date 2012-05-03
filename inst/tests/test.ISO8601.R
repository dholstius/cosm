context('ISO8601')

options(digits.secs=3)
x <- as.POSIXlt("2012-05-02 14:53:57.125", tz="UTC")

test_that('encoding', {
	expect_equal(encode.ISO8601(x), "2012-05-02T14:53:57.125+0000")
})

test_that('decoding', {
	expect_equal(decode.ISO8601(encode.ISO8601(x), tz="UTC"), x)
})
