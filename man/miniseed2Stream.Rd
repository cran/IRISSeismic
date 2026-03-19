\name{miniseed2Stream}

\alias{miniseed2Stream}

\title{Convert miniSEED bytes to \code{Stream} object}

\description{
The \code{miniseed2Stream} function converts raw miniSEED bytes into a 
\code{Stream} object.
}

\usage{
miniseed2Stream(miniseed, url, requestedStarttime, requestedEndtime,
                sensor, scale, scalefreq, scaleunits, latitude, longitude,
                elevation, depth, azimuth, dip, removeZeroSampleTraces)
}

\arguments{
  \item{miniseed}{a vector of raw bytes read from a miniSEED file}
  \item{url}{optional, character source location (see \link{getDataselect})}
  \item{requestedStarttime}{optional, \code{POSIXct} time associated with the 
        requested starttime (see \link{getDataselect})}
  \item{requestedEndtime}{optional, \code{POSIXct} time associated with the 
        requested endtime (see \link{getDataselect})}
  \item{sensor}{optional, character description of the Sensor type associated 
        with this Station-Network-Channel-Location (SNCL) (see \link{Trace})}
  \item{scale}{optional, character description of the InstrumentSensitivity 
        associated with this SNCL (see \link{Trace})}
  \item{scalefreq}{optional, numeric description of frequency at which the 
        InstrumentSensitivity is correct, the SensitivityFrequency 
        (see \link{Trace})}
  \item{scaleunits}{optional, character description of the InputUnits 
        associated with this SNCL (see \link{Trace})}
  \item{latitude}{optional, numeric latitude associated with this SNCL 
        (see \link{Trace})}
  \item{longitude}{optional, numeric longitude associated with this SNCL 
        (see \link{Trace})}
  \item{elevation}{optional, numeric elevation associated with this SNCL 
        (see \link{Trace})}
  \item{depth}{optional, numeric depth associated with this SNCL 
        (see \link{Trace})}
  \item{azimuth}{optional, numeric channel azimuth associated with this SNCL 
        (see \link{Trace})}
  \item{dip}{optional, numeric channel dip associated with this SNCL 
        (see \link{Trace})}
  \item{removeZeroSampleTraces}{optional, logical determining whether traces with no 
        sample values are removed (default = TRUE)} 
}

\details{
This function takes raw bytes read in from a file or URL and converts them to a 
\code{Stream} object. Metadata information is optional. 
This function is primarily for internal use.
}

\value{
A \code{Stream} object.}

%% \references{ }

\author{
Jonathan Callahan \email{jonathan@mazamascience.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
 \code{\link{readMiniseedFile}}
}


