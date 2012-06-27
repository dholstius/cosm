\name{feed_history}
\alias{feed_history}
\title{feed_history}
\usage{
  feed_history(feed, key, datastreams, ...)
}
\arguments{
  \item{datastreams}{datastream ID or IDs (optional; if
  none supplied will return all)}

  \item{feed}{feed ID}

  \item{key}{API key}

  \item{...}{(optional) query string arguments, of the form
  key=value}
}
\value{
  zoo object, or NULL if empty
}
\description{
  Fetch datapoints from a given feed or datastream
}

