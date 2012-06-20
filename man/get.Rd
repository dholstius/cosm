\name{getFeed}
\alias{getDatapoints}
\alias{getFeed}
\title{getFeed}
\usage{
  getFeed(feed, key, ...)

  getDatapoints(feed, key, datastreams, ...)
}
\arguments{
  \item{feed}{feed ID}

  \item{key}{API key}

  \item{...}{(optional) query string arguments, of the form
  key=value}

  \item{datastream}{datastream ID or IDs (optional; if none
  supplied will return all)}
}
\value{
  a Feed object (inherits from list)

  zoo object
}
\description{
  Fetch data from Cosm

  Fetch datapoints from a given feed or datastream
}
\note{
  pass per_page=1000 to get the maximum number of results
}

