\name{getDataAvailability}
\docType{methods}
\alias{getDataAvailability}
\alias{getDataAvailability,IrisClient,character,character,character,character,POSIXct,POSIXct-method}

\title{Retrieve miniseed trace extents from IRIS DMC}

\description{
The \code{getDataAvailability} method obtains miniseed time extents from the IRIS DMC 
\code{availability} web service and returns it in a dataframe.
}

\usage{
getDataAvailability(obj, network, station, location, channel,starttime, endtime,
                     mergequality, mergesamplerate, mergeoverlap, mergetolerance, 
                     includerestricted, excludetoolarge)
}

\arguments{
  \item{obj}{ \code{IrisClient} object }
  \item{network}{ character string with the two letter seismic network code }
  \item{station}{ character string with the station code }
  \item{location}{ character string with the location code }
  \item{channel}{ character string with the three letter channel code }
  \item{starttime}{ POSIXct class specifying the starttime (GMT) }
  \item{endtime}{ POSIXct class specifying the endtime (GMT) }
  \item{mergequality}{optional logical identifying if timespans with differing qualities are grouped together 
                      (default=\code{FALSE})}
  \item{mergesamplerate}{optional logical identifying if timespans from data with differing sample rates are grouped 
                         together (default=\code{FALSE})}
  \item{mergeoverlap}{optional logical identifying if overlapping timespans are merged together (default=\code{FALSE})}
  \item{mergetolerance}{optional numeric. If \code{mergeoverlap=TRUE}, timespans which are separated by gaps smaller 
                         than or equal to the mergetolerance value are merged together. To have an effect, the mergetolerance 
                         value must be larger than 1.5 times the sample period. }
  \item{includerestricted}{ optional logical identifying whether to report on restricted data (default=\code{FALSE}) }
  \item{excludetoolarge}{ optional logical identifying whether to ignore channels that are too fragmented for
                         the availability service to process (default=\code{TRUE}). If FALSE, the service reports a 413 
                         error (request too large) if any of these channels are selected. }
}


\details{
The \code{getDataAvailability} method uses the IRIS availability service to obtain start and endtimes for all continuous trace 
segments in the IRIS archive for the requested network, station, location, channels and returns that data in a dataframe. 
Each row of the dataframe represents a unique data trace extent. 

Each of the arguments \code{network}, \code{station}, \code{location} or \code{channel} may contain
a valid code or a wildcard expression, e.g. "BH?" or "*". Empty strings are converted to "*".
Otherwise the ascii string that is used for these values is simply inserted into the web service request URL.

For more details see the \href{http://service.iris.edu/irisws/availability/1/}{web service documentation}.
}

\value{
A dataframe with the following columns:

  %% max preformatted length ---------------------------------------------------
  \preformatted{
  network, station, location, channel, repository, samplerate, starttime, endtime, snclId 
  }

  Rows are ordered by \code{snclId}.

  The snclId column, eg. "US.OCWA..BHE", is generated as a convenience. It is not part of
  the normal return from the station web service.

}

\references{
%% ~put references to the literature/web site here ~
The IRIS DMC station web service:

  \url{http://service.iris.edu/irisws/availability/1/}

}

\author{
Gillian Sharer \email{gillian@iris.washington.edu}
}


\seealso{
  \code{\link{IrisClient-class}}
}

%% max preformatted length ---------------------------------------------------
\examples{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient")

starttime <- as.POSIXct("2018-01-01",tz="GMT")
endtime <- as.POSIXct("2019-01-01",tz="GMT")
network <- "TA"
station <- "M22K"
channel <- "BHZ"

traceList <- getDataAvailability(iris,network,station,"*",channel,starttime,endtime)
traceList
}

\keyword{webservices}
