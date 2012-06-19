require(cosm)
require(lubridate)
		
key <- 'bZW0wu4jbqMrkzHhapw8E9axBHaSAKx5YmE4TndXejRqOD0g'
end <- Sys.time()
start <- end - 12 * 3600

Shinyei <- getDatapoints(58924, 'raw', key, start=start, end=end, interval=30)
Dylos <- getDatapoints(58786, 'total', key, start=start, end=end, interval=30)

par(mfrow=c(2, 1))
plot(Dylos, main="Dylos, raw 1 minute readings")
plot(Shinyei, main="Shinyei, raw 1 minute readings")

minutes <- function(align=5) {
	function(i) {
		i <- trunc(i, 'mins')
		i - (minute(i) %% align) * 60
	}
}

medians <- function(z) aggregate(z, minutes(align=5), FUN=median)
smoothed <- function(z) smooth(medians(z))

par(mfrow=c(1, 1))
plot(scale(smoothed(Dylos)), type="l", main="Dylos (line) vs Shinyei (points), smoothed and normalized, 5 minute intervals")
points(scale(smoothed(Shinyei)))

par(mfrow=c(1, 1))
summary(fit.lm <- lm(smoothed(Dylos) ~ smoothed(Shinyei)))
plot(smoothed(Shinyei), smoothed(Dylos), main="Dylos vs Shinyei, smoothed and normalized, 5 minute intervals")
abline(fit.lm, col="red")
