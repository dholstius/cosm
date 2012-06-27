\name{feed_detail}
\alias{feed_detail}
\title{feed_detail}
\usage{
  feed_detail(feed, key, ...)
}
\arguments{
  \item{feed}{feed ID}

  \item{key}{API key}

  \item{...}{(optional) query string arguments, of the form
  key=value}
}
\value{
  a Feed object (inherits from list)
}
\description{
  Fetch data from Cosm
}
\note{
  pass per_page=1000 to get the maximum number of results
}

