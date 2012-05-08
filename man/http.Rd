\name{httpHeader}
\alias{httpGet}
\alias{httpHeader}
\title{httpHeader}
\usage{
  httpHeader(key, accept)

  httpGet(url, header, ...)
}
\arguments{
  \item{key}{Pachube API key}

  \item{url}{Pachube url (see \link{feedUrl})}

  \item{header}{see \link{httpHeader}}
}
\value{
  a list

  character
}
\description{
  Construct an object to serve as a request header in an
  RCurl call

  Wrapper for similar RCurl methods
}

