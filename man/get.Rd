\name{getFeed}
\alias{getDatapoints}
\alias{getFeed}
\title{getFeed}
\usage{
  getFeed(feed, key, ...)

  getDatapoints(feed, datastream, key, ...)
}
\arguments{
  \item{feed}{feed ID}

  \item{key}{API key}

  \item{...}{(optional) query string arguments, of the form
  key=value}

  \item{datastream}{datastream ID}
}
\value{
  a Feed object (inherits from list)

  a zoo object
}
\description{
  Fetch data from Pachube

  Fetch just the datapoints from a given datastream
}
\note{
  pass per_page=1000 to get the maximum number of results
}

