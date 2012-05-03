require(ggplot2)
require(reshape)
require(scales)

# ID for "UHall575AB" feed
feed <- '57883'

# Read-only API key for this feed
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'

# Fetch data from the last 6 hours
start <- encode.ISO8601(Sys.time() - 12 * 3600)
Temperature <- queryDatastream(feed, 'Temperature', key, start=start)
Humidity <- queryDatastream(feed, 'Humidity', key, start=start)
PM_Large <- queryDatastream(feed, 'PM_Large', key, start=start)
PM_Small <- queryDatastream(feed, 'PM_Small', key, start=start)

# Merge observations from the same sensor
SHT15.zoo <- merge(Temperature, Humidity)
DC1700.zoo <- merge(PM_Large, PM_Small)

# Convert zoo objects to data.frames, adding a 'Timestamp' column
SHT15.data <- data.frame(SHT15.zoo, Timestamp=index(SHT15.zoo))
DC1700.data <- data.frame(DC1700.zoo, Timestamp=index(DC1700.zoo))

# Plot temperature data with different loess smoothers
scale.timestamp <- scale_x_datetime('Timestamp', 
	breaks = date_breaks('4 hours'),
	minor_breaks = date_breaks('1 hour'),
	labels = date_format('%m/%d %H:%M'))
p <- ggplot(SHT15.data, aes(Timestamp, Temperature))
p <- p + geom_point() + scale.timestamp
show(p)
show(p + geom_smooth(span=0.5))
show(p + geom_smooth(span=0.2))

# Plot two series ...
molten <- melt(DC1700.data, id.var='Timestamp')
p <- ggplot(molten, aes(Timestamp, value, color=variable))

# ... on the same chart, with the same y scale
show(p + geom_line())

# ... or on different charts, with different y scales
show(p + geom_line() + facet_wrap(~ variable, ncol=1, scales='free_y'))

# Here is a plot of all the series together
all.data <- merge(Temperature, Humidity, PM_Large, PM_Small)
all.data <- data.frame(all.data, Timestamp=index(all.data))
p <- ggplot(melt(all.data, id.var='Timestamp'), aes(Timestamp, value))
p <- p + geom_point() + geom_smooth(span=0.2) + facet_wrap(~ variable, ncol=1, scales='free_y')
show(p + scale.timestamp)