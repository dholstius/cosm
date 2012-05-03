\name{queryDatastream}
\alias{queryDatastream}
\title{queryDatastream}
\usage{
  queryDatastream(feed, datastream, key, ...)
}
\arguments{
  \item{feed}{feed ID (ex: '57883')}

  \item{datastream}{datastream ID (ex: 'Temperature')}

  \item{key}{Pachube API key (for the given feed)}

  \item{...}{query string arguments, of the form key=value}
}
\description{
  Fetch time-series data from Pachube
}

