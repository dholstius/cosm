# Feed ID for "U Hall 575B"
feed <- '57883'

# Read-only API key for this feed
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'

# Fetch and plot temperature data from 12 hours ago
start <- encode.ISO8601(Sys.time() - 12 * 3600)
Temperature <- getDatapoints(feed, 'SHT15_T_Celsius', key, start=start)
plot(Temperature)
