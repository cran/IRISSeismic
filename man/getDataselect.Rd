\name{getDataselect}
\alias{getDataselect}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,character,logical,logical-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,missing,missing,missing-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,character,logical,missing-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,character,missing,logical-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,missing,logical,logical-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,character,missing,missing-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,missing,missing,logical-method}
\alias{getDataselect,IrisClient,character,character,character,character,POSIXct,POSIXct,missing,logical,missing-method}

\title{Retrieve seismic data from IRIS DMC}

\description{
The \code{getDataselect} method makes a request of the IRIS DMC \code{dataselect} 
webservice and returns a \code{Stream} object in which individual \code{Traces}
have been sorted by start time.
}

\usage{
getDataselect(obj, network, station, location, channel, 
              starttime, endtime, quality, inclusiveEnd, ignoreEpoch)
}

\arguments{
  \item{obj}{ \code{IrisClient} object}
  \item{network}{character string with the two letter seismic network code}
  \item{station}{character string with the station code}
  \item{location}{character string with the location code}
  \item{channel}{character string with the three letter channel code}
  \item{starttime}{POSIXct class specifying the starttime (GMT)}
  \item{endtime}{POSIXct class specifying the endtime (GMT)}
  \item{quality}{optional character string identifying the quality. IRIS webservices defaults to quality="M".}
  \item{inclusiveEnd}{optional logical determining whether the endtime is inclusive (default = TRUE)}
  \item{ignoreEpoch}{optional logical defining behavior when multiple epochs are encountered (default = FALSE)}
}

\details{
This is the primary method for retrieving seismic data.  Data requests are made through
the \code{dataselect} webservice and returned data are parsed using
the internal miniseed2Stream() function.

If the location argument contains an empty string to specify a 'blank' location code, a location
code of \code{"--"} will be used in the dataselect request URL.
(See \href{http://service.iris.edu/fdsnws/dataselect/1/}{dataselect documentation}.)

If \code{inclusiveEnd=FALSE}, then \code{getDataselect} will subtract 0.000001 seconds from the endtime before passing the 
value to the \code{dataselect} webservice. An endtime of, e.g., \code{as.POSIXct("2016-01-03", tz="GMT")} will be passed 
into \code{dataselect} as \code{end=2016-01-02T23:59:59.999999}. A data sample at time 2016-01-03T00:00:00 will not be returned
unless \code{inclusiveEnd=TRUE}.

Error returns from the webservice will stop evaluation and generate an error message.

Sometimes, the station webservice will return multiple records for the same SNCL,
each with a different scale or starttime.  These represent different \emph{epochs} with
potentially different metadata parameters for the SNCL and, by default, will cause
a 'Multiple epochs' error message to be generated.

Handling all possible metadata differences so that the data may be merged is beyond the scope of this
package. Instead, to avoid errors, users may specify \code{default=TRUE} in which case
the very first SNCL-epoch encountered will be used and all others will be discarded.
}

\value{
A new \code{Stream} object is returned.
}

\references{
%% ~put references to the literature/web site here ~
The IRIS DMC dataselect webservice:

  \url{http://service.iris.edu/fdsnws/dataselect/1/}

This implementation is similar in functionality to the obspy dataselect function:

  \url{http://docs.obspy.org/_modules/obspy/clients/fdsn/client.html#Client.dataselect}
}

\author{
Jonathan Callahan \email{jonathan@mazamascience.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{getSNCL}}, 
\code{\link{IrisClient-class}}
}

\examples{ 
   \dontrun{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient")

# Use getDataselect to request data for II.JTS.00.BHZ
starttime <- as.POSIXct("2001-02-28",tz="GMT")
endtime <- as.POSIXct("2001-03-01",tz="GMT")

st <- getDataselect(iris, "II","JTS","00","BHZ",starttime, endtime, 
                    inclusiveEnd=FALSE,ignoreEpoch=TRUE)

# Display structure of trace(s)

str(st)

# Plot trace
plot(st)
   }
}

\keyword{webservices}
