\name{IrisClient-class}
\Rdversion{1.1}
\docType{class}

\alias{IrisClient-class}

\title{ Class \code{"IrisClient"} }

\description{
A class for making data and metadata requests from IRIS DMC web services.
}

\section{Slots}{
  \describe{
    \item{\code{site}:}{Object of class \code{"character"}:
    defaults to \code{http://service.iris.edu} which should be very stable }
    %%\item{\code{user}:}{Object of class \code{"character"}:
    %%user name for web authentication \b{not implemented}}
    %%\item{\code{password}:}{Object of class \code{"character"}:
    %%password for web authentication \b{not implemented}}
    %%\item{\code{timeout}:}{Object of class \code{"integer"}:
    %%connection timeout \b{not implemented}}
    \item{\code{debug}:}{Object of class \code{"logical"}:
    when set to TRUE will cause any web service requestURL to be printed }
    \item{\code{useragent}:}{Object of class \code{"character"}:
    client identification string }
  }
}
\section{Methods}{
  \describe{
    \item{getAvailability}{
    makes a channel request of the station web service and returns the result as a dataframe; see \code{\link{getAvailability}} }
    \item{getChannel}{
    makes a channel request of the station web service and returns the result as a dataframe; see \code{\link{getChannel}} }
    \item{getDataselect}{
    makes a request of the dataselect web service and returns a \code{Stream} object; see \code{\link{getDataselect}} }
    \item{getDistaz}{
    makes a request of the distaz web service and returns a the information as a dataframe; see \code{\link{getDistaz}} }
    \item{getEvalresp}{
    makes a request of the instrument response web service and returns the information as a dataframe; see \code{\link{getEvalresp}} }
    \item{getEvent}{
    makes a request of the event web service and returns the information as a dataframe; see \code{\link{getEvent}} }
    \item{getNetwork}{
    makes a network request of the station web service and returns the result as a dataframe; see \code{\link{getNetwork}} }
    \item{getSNCL:}{
    calls the \code{getDataselect} method and returns a \code{Stream} object; see \code{\link{getSNCL}} }
    \item{getStation}{
    makes a station request of the station web service and returns the result as a dataframe; see \code{\link{getStation}} }
    \item{getTraveltime}{
    makes a request of the traveltime web service and returns the information as a dataframe; see \code{\link{getTraveltime}} }
    \item{getUnavailability}{
    makes a channel request of the station web service and returns the result as a dataframe; see \code{\link{getUnavailability}} }
	 }
}

%% \references{ }

\author{
Jonathan Callahan \email{jonathan@mazamascience.com}
}

\note{
The \code{IrisClient} object is inspired by the \code{clients.fdsn.client.Client} class found in the
python ObsPy package (\url{http://docs.obspy.org/packages/autogen/obspy.clients.fdsn.client.Client.html#obspy.clients.fdsn.client.Client}).
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%% \seealso{ }

\examples{
  \dontrun{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient", debug=TRUE)

starttime <- as.POSIXct("2012-01-24", tz="GMT")
endtime <- as.POSIXct("2012-01-25", tz="GMT")

# Get the waveform
st <- getDataselect(iris,"AK","PIN","","BHZ",starttime,endtime)
mean(st)
  }
}

\keyword{classes}
