# Feed ID for "U Hall 575B"
feed <- '57883'

# Read-only API key for this feed
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'

# Fetch and plot temperature data from the past 12 hours
start <- encode.ISO8601(Sys.time() - 12 * 3600)
Temperature <- getDatapoints(feed, 'SHT15_T_Celsius', key, start=start)
plot(Temperature)

# Fetch small and large PM counts, but at 1-minute intervals
# Note that we need to pass "per_page=1000" to get all the results in one request
interval <- 1 * 60
total <- getDatapoints(feed, 'DC1700_small', key, start=start, interval=interval, per_page=1000)
large <- getDatapoints(feed, 'DC1700_large', key, start=start, interval=interval, per_page=1000)

# Merge the results, converting from 0.01cf^-1 to m^-3
DC1700 <- merge(total, large) * 100 * 0.0283168466

# Subtract to estimate the fraction between 0.5 and 2.5 um
plot(with(DC1700, total - large), 
	xlab = 'Timestamp', 
	ylab = expression(count/m^3), 
	main = expression(PM[2.5-0.5]))