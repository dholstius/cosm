\name{http_get}
\alias{http_get}
\title{http_get}
\usage{
  http_get(url, header, curl = getCurlHandle(), ...,
    per_page = 1000)
}
\arguments{
  \item{url}{Cosm url (see \link{feed_url})}

  \item{header}{see \link{http_header}}

  \item{curl}{curl handle (reusable if making multiple
  calls)}

  \item{per_page}{maximum number of results (pass page=2 to
  fetch more)}

  \item{...}{additional key-value pairs (see
  http://cosm.com/docs/)}
}
\value{
  character
}
\description{
  Wrapper for similar RCurl methods
}

