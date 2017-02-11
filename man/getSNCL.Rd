\name{getSNCL}
\docType{methods}
\alias{getSNCL}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,character,logical,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,missing,missing,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,character,logical,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,character,missing,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,missing,logical,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,character,logical,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,character,missing,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,missing,missing,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,missing,logical,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,character,logical,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,character,missing,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,missing,logical,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,character,missing,missing,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,missing,missing,logical-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,missing,logical,missing-method}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing,character,missing,missing-method}

\title{Retrieve seismic data from IRIS DMC}

\description{
The getSNCL() method is a convenience wrapper for the getSNCL() method
and returns a \code{Stream} object in which individual \code{Traces}
have been sorted by start time.
}

\usage{
getSNCL(obj, sncl, starttime, endtime, quality, repository, inclusiveEnd, ignoreEpoch)
}

\arguments{
  \item{obj}{ \code{IrisClient} object }
  \item{sncl}{ character string with the SNCL code }
  \item{starttime}{ POSIXct class specifying the starttime (GMT) }
  \item{endtime}{ POSIXct class specifying the endtime (GMT) }
  \item{quality}{ optional character string identifying the quality. IRIS webservices defaults to quality="M". }
  \item{repository}{optional character string identifying whether to exclusively search primary archive or realtime collection buffers.
     Acceptable values are "primary" or "realtime". If not specified, IRIS webservices defaults to searching both repositories.}
  \item{inclusiveEnd}{optional logical determining whether the endtime is inclusive (default = TRUE)}
  \item{ignoreEpoch}{optional logical defining behavior when multiple epochs are encountered (default = FALSE)}
}

\details{
The SNCL argument should be ordered network-station-location channel, e.g. \code{IU.ANMO.00.LHZ}.
This argument is split into component parts which are then used in a call to the
getSNCL() method.
}

\value{
A new \code{Stream} object is returned.
}

\references{
%% ~put references to the literature/web site here ~
The IRIS DMC dataselect web service:

  \url{http://service.iris.edu/fdsnws/dataselect/1/}
}

\author{
Jonathan Callahan \email{jonathan@mazamascience.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{getDataselect}}, 
\code{\link{IrisClient-class}}
}

\examples{ 
  \dontrun{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient")

# Use getSNCL to request data for II.JTS.00.BHZ
starttime <- as.POSIXct("2001-02-28",tz="GMT")
endtime <- as.POSIXct("2001-03-01",tz="GMT")

st <- getSNCL(iris, "II.JTS.00.BHZ",starttime, endtime, quality="M",
              repository="primary",inclusiveEnd=FALSE,ignoreEpoch=TRUE)

# Display structure of trace(s)

str(st)

# Plot trace
plot(st)
  }
}
\keyword{webservices}
