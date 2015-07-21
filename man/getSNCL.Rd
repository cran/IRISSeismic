\name{getSNCL}
\docType{methods}
\alias{getSNCL}
\alias{getSNCL,IrisClient,character,POSIXct,POSIXct,missing-method}

\title{Retrieve seismic data from IRIS DMC}

\description{
The getSNCL() method is a convenience wrapper for the getDataselect() method
and returns a \code{Stream} object in which individual \code{Traces}
have been sorted by start time.
}

\usage{
getSNCL(obj, sncl, starttime, endtime, quality)
}

\arguments{
  \item{obj}{ \code{IrisClient} object }
  \item{sncl}{ character string with the SNCL code }
  \item{starttime}{ POSIXct class specifying the starttime (GMT) }
  \item{endtime}{ POSIXct class specifying the endtime (GMT) }
  \item{quality}{ optional character string identifying the quality (default = "B") }
}

\details{
The SNCL argument should be ordered network-station-location channel, e.g. \code{IU.ANMO.00.LHZ}.
This argument is split into component parts which are then used in a call to the
getDataselect() method.
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
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{getDataselect}}, 
\code{\link{IrisClient-class}}
}

%% \examples{ }

\keyword{webservices}
