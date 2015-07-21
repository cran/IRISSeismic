\name{getDistaz}
\docType{methods}
\alias{getDistaz}
\alias{getDistaz,IrisClient,numeric,numeric,numeric,numeric-method}

\title{Retrieve great circle distance information from IRIS DMC}

\description{
The \code{getDistaz} method obtains great circle distance data from
the IRIS DMC \code{distaz} web service.
}

\usage{
getDistaz(obj, latitude, longitude, staLatitude, staLongitude)
}

\arguments{
  \item{obj}{ an \code{IrisClient} object }
  \item{latitude}{ latitude of seismic event }
  \item{longitude}{ longitude of seismic event }
  \item{staLatitude}{ latitude of seismic station }
  \item{staLongitude}{ longitude of seismic station }
}

\details{
The distance-azimuth service will calculate the great-circle angular distance, azimuth,
and backazimuth between two geographic coordinate pairs. All results are reported in
degrees, with azimuth and backazimuth measured clockwise from North.
}


\value{
A dataframe with the following columns:

\preformatted{
azimuth, backAzimuth, distance
}

Only a single row is returned.
}

\references{
The IRIS DMC distaz webservice:

  \url{http://service.iris.edu/irisws/distaz/1/}
}

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{IrisClient-class}}
}

%% \examples{ }

\keyword{webservices}
