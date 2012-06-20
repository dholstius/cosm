\name{httpGet}
\alias{httpGet}
\title{httpGet}
\usage{
  httpGet(url, header, curl = getCurlHandle(), ...,
    per_page = 1000)
}
\arguments{
  \item{url}{Cosm url (see \link{feedUrl})}

  \item{header}{see \link{httpHeader}}

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

