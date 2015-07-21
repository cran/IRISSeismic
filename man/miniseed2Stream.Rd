\name{miniseed2Stream}

\alias{miniseed2Stream}

\title{Convert miniSEED bytes to \code{Stream} object}

\description{
The \code{miniseed2Stream} function converts raw miniSEED bytes into a \code{Stream}
object.
}

\usage{
miniseed2Stream(miniseed,url,requestedStarttime,requestedEndtime,
                sensor,scale,scaleunits)
}

\arguments{
  \item{miniseed}{a vector of raw bytes read from a miniSEED file}
  \item{url}{character source location (see \link{getDataselect})}
  \item{requestedStarttime}{\code{POSIXct} time associated with the requested starttime (see \link{getDataselect})}
  \item{requestedEndtime}{\code{POSIXct} time associated with the requested endtime (see \link{getDataselect})}
  \item{sensor}{character description of the Sensor associated with this SNCL (see \link{Trace})}
  \item{scale}{character description of the InstrumentSensitivity associated with this SNCL (see \link{Trace})}
  \item{scaleunits}{character description of the InputUnits associated with this SNCL (see \link{Trace})}
}

\details{
This function takes raw bytes read in from a file or URL and converts them to a \code{Stream} object.
This function is primarily for internal use.
}

\value{
A \code{Stream} object.}

%% \references{ }

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
 \code{\link{readMiniseedFile}}
}

%% \examples{ }

